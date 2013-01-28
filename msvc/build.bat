@Echo off 

echo.
echo Setting Program Files Folder...
echo.

REM Some computers (non-64-bit) don't have a ProgramFiles(x86) folder, so fall back on ProgramFiles in such cases
if "%ProgramFiles(x86)%" == "" (
	set PROGRAM_FILES=%ProgramFiles%
) else (
	set PROGRAM_FILES=%ProgramFiles(x86)%
)

echo.
echo Detecting the newest version of Visual Studio...
echo.
REM Start with most recent version
set VS_VERSION=11
set VS_YEAR=2012
set VSHOME=%PROGRAM_FILES%\Microsoft Visual Studio %VS_VERSION%.0

REM Cascade down
if not exist "%VSHOME%" (
	set VS_VERSION=10
	set VS_YEAR=2010
	set VSHOME=%PROGRAM_FILES%\Microsoft Visual Studio %VS_VERSION%.0
	
	if not exist "%VSHOME%" (
		set VS_VERSION=9
		set VS_YEAR=2008
		set VSHOME=%PROGRAM_FILES%\Microsoft Visual Studio %VS_VERSION%.0
		
		if not exist "%VSHOME%" (
			echo Please install Visual Studio Express 2012 Desktop
			goto end
		)
	)
)

REM Visual Studio versions after 2008, use the extention .vcxproj rather than .vcproj
if %VS_VERSION% gtr 9 (
	set VCPROJ=vcxproj
) else (
	set VCPROJ=vcproj
)
	
if %VS_YEAR% gtr 2010 (
	set MAX_2010=2010
) else (
	set MAX_2010=%VS_YEAR%
)


echo.
echo Detected Visual Studio %VS_YEAR%
echo Setting Global Variables...
echo.

set TOP=%CD%
set TOP_DEPS=%TOP%\deps
set QT_BIN=c:\Qt\4.7.3-msvc2008\bin
set VS_VARS="%VSHOME%\VC\vcvarsall.bat"
set POPPLER_SRC=%TOP%\src\poppler-0.22.0
set POPPLER_BUILD=%TOP%\src\poppler-0.22.0-build
set UTILS_PATH=%TOP%\utils
set PATH=%UTILS_PATH%;%PATH%
set INSTALL_PREFIX=%CD%\build

if not exist "%POPPLER_BUILD%" (
  mkdir "%POPPLER_BUILD%"
)

echo.
echo Downloading poppler 0.22.0 source and patching...
echo.

call setenv.bat
wget -nc -P .\arch http://poppler.freedesktop.org/poppler-0.22.0.tar.gz
bsdtar xzf arch\poppler-0.22.0.tar.gz -C src 
patch -t --forward -d src\poppler-0.22.0\ -p1 < patches\poppler-0.22.0.patch

echo.
echo Getting dependency source code...
echo.
call get_deps.bat



echo.
echo Building...
echo.

cd %POPPLER_BUILD%
 
cmake -G "Visual Studio %VS_VERSION%" "%POPPLER_SRC%"  ^
  -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"^
  -DQT_QMAKE_EXECUTABLE="%QT_BIN%/qmake.exe"^
  -DCMAKE_CXX_FLAGS:STRING=" /DWIN32 /D_WINDOWS /W3 /Zm1000 /EHsc /GR"^
  -DCMAKE_CXX_FLAGS_DEBUG:STRING="/D_DEBUG /MDd /Zi /Ob0 /Od /RTC1"^
  -DCMAKE_CXX_FLAGS_MINSIZEREL:STRING="/MD /O1 /Ob1 /D NDEBUG -DQT_NO_DEBUG"^
  -DCMAKE_CXX_FLAGS_RELEASE:STRING="/MD /O2 /Ob2 /D NDEBUG -DQT_NO_DEBUG"^
  -DCMAKE_CXX_FLAGS_RELWITHDEBINFO:STRING="/MD /Zi /O2 /Ob1 /D NDEBUG -DQT_NO_DEBUG"^
  -DCMAKE_LINKER:FILEPATH="%PROGRAM_FILES%\Microsoft Visual Studio %VS_VERSION%.0\VC\bin\cl.exe"^
  -DCMAKE_CXX_STANDARD_LIBRARIES:STRING="kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib "^
  -DCMAKE_INCLUDE_PATH:FILEPATH=%TOP_DEPS%^
  -DLIB_SUFFIX:STRING=""^
  -DPKG_CONFIG_EXECUTABLE:FILEPATH="PKG_CONFIG_EXECUTABLE-NOTFOUND"^
  -DICONV_INCLUDE_DIR:PATH="%TOP_DEPS%/libiconv/include"^
  -DICONV_LIBRARIES:FILEPATH="%TOP_DEPS%/libiconv/lib/iconv.lib"^
  -DFREETYPE_INCLUDE_DIR_ft2build:PATH="%TOP_DEPS%/freetype/include"^
  -DFREETYPE_INCLUDE_DIR_freetype2:PATH="%TOP_DEPS%/freetype/include/freetype2"^
  -DFREETYPE_LIBRARY:FILEPATH="%TOP_DEPS%/freetype/lib/freetype.lib"^
  -DCAIRO_INCLUDE_DIR:PATH="%TOP_DEPS%/cairo/include/cairo"^
  -DCAIRO_LIBRARY:FILEPATH="%TOP_DEPS%/cairo/lib/cairo.lib"^
  -DFONTCONFIG_INCLUDE_DIR:PATH="%TOP_DEPS%/fontconfig/include"^
  -DFONTCONFIG_LIBRARIES:FILEPATH="%TOP_DEPS%/fontconfig/lib/fontconfig.lib"^
  -DFONT_CONFIGURATION:STRING="win32"^
  -DENABLE_LIBOPENJPEG:BOOL="0"^
  -DENABLE_ZLIB:BOOL="1"^
  -DJPEG_INCLUDE_DIR:PATH="%TOP_DEPS%/libjpeg/include"^
  -DJPEG_LIBRARY:FILEPATH="%TOP_DEPS%/libjpeg/lib/jpeg.lib"^
  -DPNG_PNG_INCLUDE_DIR:PATH="%TOP_DEPS%/libpng/include"^
  -DPNG_LIBRARY:FILEPATH="%TOP_DEPS%/libpng/lib/libpng_static.lib"^
  -DTIFF_INCLUDE_DIR:PATH="%TOP_DEPS%/libtiff/include"^
  -DTIFF_LIBRARY:FILEPATH="%TOP_DEPS%/libtiff/lib/libtiff.lib"^
  -DZLIB_INCLUDE_DIR:PATH="%TOP_DEPS%/zlib/include"^
  -DZLIB_LIBRARY:FILEPATH="%TOP_DEPS%/zlib/lib/zdll1.lib"^
  -DLCMS2_INCLUDE_DIR:PATH="%TOP_DEPS%/lcms2-2.4/include"^
  -DLCMS2_LIBRARIES:FILEPATH="%TOP_DEPS%/lcms2-2.4/Lib/MS/lcms2_static.lib"^
  -DWITH_PNG:BOOL=ON

call %VS_VARS% x86
msbuild poppler.sln /t:ALL_BUILD /p:Configuration="Release"
msbuild INSTALL.%VCPROJ% /p:Configuration="Release"

cd ..
cd ..

echo.
echo Getting runtime dependency dlls...
echo.
call get_runtime_deps.bat

copy .\post_build_files\*.* .\build\bin\*.*

:end