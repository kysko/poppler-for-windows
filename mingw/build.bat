@rem echo off

@rem first parameter: branch to build: could be master or any of the listed by "git tag" command. Default is "master"
set POPPLER_BRANCH=%1%

@rem directory where to place product. Default is %TOP%\poppler-install\%TARGET_PLATFORM%\%POPPLER_BRANCH%
set INSTALL_PREFIX=%2%

@rem target platform: x86 or x64 (x64 is not working currently)
set TARGET_PLATFORM=%3%

set POPPLER_BUILD_TOP=.\poppler-build

rem set POPPLER_BRANCH=master

if "%POPPLER_BRANCH%" == "" set POPPLER_BRANCH=master
if "%TARGET_PLATFORM%" == "" set TARGET_PLATFORM=x86
    

set POPPLER_BUILD_DIR=%POPPLER_BUILD_TOP%\%TARGET_PLATFORM%\%POPPLER_BRANCH%

if not exist "%POPPLER_BUILD_DIR%" (
  mkdir "%POPPLER_BUILD_DIR%"
)

@call setenv.bat %TARGET_PLATFORM%

@rem setup "INSTALL_PREFIX" if not provided as command line parameter
if "%INSTALL_PREFIX%" == "" set INSTALL_PREFIX=%TOP%\poppler-install\%TARGET_PLATFORM%\%POPPLER_BRANCH%

pushd %CD%
@call get_deps_%TARGET_PLATFORM%.bat
rem echo "current dir: %CD%"
popd

echo "TARGET_PLATFORM=%TARGET_PLATFORM%"

@call get_poppler.bat


@echo checking out sources
pushd %CD%
cd %POPPLER_SRC%
echo "checking out branch %POPPLER_BRANCH%"
git checkout %POPPLER_BRANCH%
git pull
popd

cd %POPPLER_BUILD_DIR%

if "%TOP_DEPS%" == "" (
    echo "Error in configuration, TOP_DEPS variable not set"
    goto :end
)

rem We should not have MSYS bin dir in path because cmake complains about it when target compiler is Mingw
set PATH=%MINGW_BIN%;%CMAKE_BIN%;%QT_BIN%;%UTILS_PATH%;%SYSTEMROOT%\System32;%PATH%
rem echo "PATH=%PATH%"

rem  TODO delete following lines when done
rem  -DFONTCONFIG_INCLUDE_DIR:PATH="%TOP_DEPS%/fontconfig/include"^
rem  -DFONTCONFIG_LIBRARIES:FILEPATH="%TOP_DEPS%/fontconfig/lib/libfontconfig.dll.a"^
rem  -DICONV_INCLUDE_DIR:PATH="%TOP_DEPS%/libiconv/include"^
rem  -DICONV_LIBRARIES:FILEPATH="%TOP_DEPS%/libiconv/lib/libiconv.a"^
rem  -DQT_QMAKE_EXECUTABLE="%QT_BIN%/qmake.exe"^

if "%TARGET_PLATFORM%" == "x64" (
cmake -G "MinGW Makefiles" %POPPLER_SRC%  ^
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
  -DPKG_CONFIG_EXECUTABLE:FILEPATH="%TOP%/utils/pkg-config.exe"^
  -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"^
  -DBUILD_CPP_TESTS:BOOL=OFF ^
  -DBUILD_QT4_TESTS:BOOL=OFF ^
  -DWITH_PNG:BOOL=ON ^
  -DWITH_Qt4:BOOL=OFF ^
  -DWITH_TIFF:BOOL=ON ^
  -DWITH_Cairo:BOOL=ON ^
  -DWITH_Iconv:BOOL=ON ^
  -DENABLE_LIBOPENJPEG:BOOL="0" ^
  -DICONV_INCLUDE_DIR:PATH="%TOP_DEPS%/libiconv/include"^
  -DICONV_LIBRARIES:FILEPATH="%TOP_DEPS%/libiconv/lib/libiconv.a"^
  -DCAIRO_INCLUDE_DIR:PATH="%TOP_DEPS%/cairo/include/cairo"^
  -DCAIRO_LIBRARY:FILEPATH="%TOP_DEPS%/cairo/lib/libcairo.a"^
  -DPNG_PNG_INCLUDE_DIR:PATH="%TOP_DEPS%/libpng/include"^
  -DPNG_LIBRARY:FILEPATH="%TOP_DEPS%/libpng/lib/libpng14.dll.a"^
  -DTIFF_INCLUDE_DIR:PATH="%TOP_DEPS%/libtiff/include"^
  -DTIFF_LIBRARY:FILEPATH="%TOP_DEPS%/libtiff/lib/libtiff.a"^
  -DFONT_CONFIGURATION:STRING="win32"^
  -DFREETYPE_INCLUDE_DIR_freetype2:PATH="%TOP_DEPS%/freetype/include/freetype2"^
  -DFREETYPE_INCLUDE_DIR_ft2build:PATH="%TOP_DEPS%/freetype/include"^
  -DFREETYPE_LIBRARY:FILEPATH="%TOP_DEPS%/freetype/lib/libfreetype.dll.a"^
  -DZLIB_INCLUDE_DIR:PATH="%TOP_DEPS%/zlib/include"^
  -DZLIB_LIBRARY:FILEPATH="%TOP_DEPS%/zlib/lib/libz.dll.a"^
  -DJPEG_INCLUDE_DIR:PATH="%TOP_DEPS%/libjpeg/include" ^
  -DJPEG_LIBRARY:FILEPATH="%TOP_DEPS%/libjpeg/lib/libjpeg.dll.a" ^
  -DLCMS2_INCLUDE_DIR:PATH="%TOP_DEPS%/lcms2/include"^
  -DLCMS2_LIBRARIES:FILEPATH="%TOP_DEPS%/lcms2/lib/liblcms2.a"^ 
) else (
cmake -G "MinGW Makefiles" %POPPLER_SRC%  ^
  -DPKG_CONFIG_EXECUTABLE:FILEPATH="%TOP%/utils/pkg-config.exe"^
  -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"^
  -DBUILD_CPP_TESTS:BOOL=OFF ^
  -DBUILD_QT4_TESTS:BOOL=OFF ^
  -DWITH_PNG:BOOL=ON ^
  -DWITH_Qt4:BOOL=OFF ^
  -DWITH_TIFF:BOOL=ON ^
  -DWITH_Cairo:BOOL=ON ^
  -DWITH_Iconv:BOOL=ON ^
  -DENABLE_LIBOPENJPEG:BOOL="0" ^
  -DCAIRO_INCLUDE_DIR:PATH="%TOP_DEPS%/cairo/include/cairo"^
  -DCAIRO_LIBRARY:FILEPATH="%TOP_DEPS%/cairo/lib/libcairo.dll.a"^
  -DPNG_PNG_INCLUDE_DIR:PATH="%TOP_DEPS%/libpng/include"^
  -DPNG_LIBRARY:FILEPATH="%TOP_DEPS%/libpng/lib/libpng16.dll.a"^
  -DTIFF_INCLUDE_DIR:PATH="%TOP_DEPS%/libtiff/include"^
  -DTIFF_LIBRARY:FILEPATH="%TOP_DEPS%/libtiff/lib/libtiff.dll.a"^
  -DFONT_CONFIGURATION:STRING="win32"^
  -DFREETYPE_INCLUDE_DIR_freetype2:PATH="%TOP_DEPS%/freetype/include/freetype2"^
  -DFREETYPE_INCLUDE_DIR_ft2build:PATH="%TOP_DEPS%/freetype/include"^
  -DFREETYPE_LIBRARY:FILEPATH="%TOP_DEPS%/freetype/lib/libfreetype.dll.a"^
  -DZLIB_INCLUDE_DIR:PATH="%TOP_DEPS%/zlib/include"^
  -DZLIB_LIBRARY:FILEPATH="%TOP_DEPS%/zlib/lib/libz.dll.a"^
  -DJPEG_INCLUDE_DIR:PATH="%TOP_DEPS%/libjpeg/include" ^
  -DJPEG_LIBRARY:FILEPATH="%TOP_DEPS%/libjpeg/lib/libjpeg.dll.a" ^
  -DLCMS2_INCLUDE_DIR:PATH="%TOP_DEPS%/lcms2/include"^
  -DLCMS2_LIBRARIES:FILEPATH="%TOP_DEPS%/lcms2/lib/liblcms2.a"^ 
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
)



echo "CMAKE DONE"
rem if %ERRORLEVEL% neq 0 goto :error

:build
mingw32-make
mingw32-make install

:runtime_deps
cd %TOP%
@rem collecting runtime dependencies #1
@call get_runtime_deps.bat %TARGET_PLATFORM%
copy /Y deps_runtime\%TARGET_PLATFORM%\ %INSTALL_PREFIX%\bin\

@rem collecting runtime dependencies #2
@rem we will copy  libexpat-1.dll, libgcc_s_dw2-1.dll, libstdc++-6.dll from MINGW_BIN directory;

for %%f in (libexpat-1.dll libgcc_s_dw2-1.dll libstdc++-6.dll) do (
    copy /Y "%MINGW_BIN%\%%f" %INSTALL_PREFIX%\bin\
)

goto :end

:error
echo "BUILD FAILED!"
exit /b -1

:end
echo "finished"
cd %TOP%
