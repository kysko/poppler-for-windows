call setenv.bat
rem call get_poppler.bat
rem call get_deps.bat

set TARGET_PLATFORM=x32
set POPPLER_BUILD_TOP=c:\temp\poppler_build_dir
set POPPLER_BRANCH=master
set POPPLER_BUILD_DIR=%POPPLER_BUILD_TOP%\%TARGET_PLATFORM%\%POPPLER_BRANCH%
set INSTALL_PREFIX=%TOP%\poppler-install\%TARGET_PLATFORM%\%POPPLER_BRANCH%

if not exist "%POPPLER_BUILD_DIR%" (
  mkdir "%POPPLER_BUILD_DIR%"
)


@echo checking out sources
pushd %CD%
cd %POPPLER_SRC%
git checkout %POPPLER_BRANCH%
git pull
popd


cd %POPPLER_BUILD_DIR%


rem We should not have MSYS bin dir in path because cmake complains about it when target compiler is Mingw
set PATH=%UTILS_BIN%;%QT_BIN%;%CMAKE_BIN%;%MINGW_BIN%

rem -DPKG_CONFIG_EXECUTABLE:FILEPATH="%TOP%/utils/pkg-config.exe"^

cmake -G "MinGW Makefiles" %POPPLER_SRC%  ^
  -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"^
  -DENABLE_LIBOPENJPEG:BOOL="0" ^
  -DCAIRO_INCLUDE_DIR:PATH="%TOP_DEPS%/cairo/include/cairo"^
  -DCAIRO_LIBRARY:FILEPATH="%TOP_DEPS%/cairo/lib/libcairo.dll.a"^
  -DPNG_PNG_INCLUDE_DIR:PATH="%TOP_DEPS%/libpng/include"^
  -DFONTCONFIG_INCLUDE_DIR:PATH="%TOP_DEPS%/fontconfig/include"^
  -DFONTCONFIG_LIBRARIES:FILEPATH="%TOP_DEPS%/fontconfig/lib/libfontconfig.dll.a"^
  -DFONT_CONFIGURATION:STRING="fontconfig"^
  -DFREETYPE_INCLUDE_DIR_freetype2:PATH="%TOP_DEPS%/freetype/include/freetype2"^
  -DFREETYPE_INCLUDE_DIR_ft2build:PATH="%TOP_DEPS%/freetype/include"^
  -DFREETYPE_LIBRARY:FILEPATH="%TOP_DEPS%/freetype/lib/libfreetype.dll.a"^
  -DICONV_INCLUDE_DIR:PATH="%TOP_DEPS%/libiconv/include"^
  -DICONV_LIBRARIES:FILEPATH="%TOP_DEPS%/libiconv/lib/libiconv.a"^
  -DJPEG_INCLUDE_DIR:PATH="%TOP_DEPS%/libjpeg/include"^
  -DJPEG_LIBRARY:FILEPATH="%TOP_DEPS%/libjpeg/lib/libjpeg.dll.a"^
  -DLCMS2_INCLUDE_DIR:PATH="%TOP_DEPS%/lcms2/include"^
  -DLCMS2_LIBRARIES:FILEPATH="%TOP_DEPS%/lcms2/lib/liblcms2.a"^ 
  -DPNG_LIBRARY:FILEPATH="%TOP_DEPS%/libpng/lib/libpng14.dll.a"^
  -DQT_QMAKE_EXECUTABLE="%QT_BIN%/qmake.exe"^
  -DTIFF_INCLUDE_DIR:PATH="%TOP_DEPS%/libtiff/include"^
  -DTIFF_LIBRARY:FILEPATH="%TOP_DEPS%/libtiff/lib/libtiff.dll.a"^
  -DZLIB_INCLUDE_DIR:PATH="%TOP_DEPS%/zlib/include"^
  -DZLIB_LIBRARY:FILEPATH="%TOP_DEPS%/zlib/lib/libz.dll.a"^
  -DLIB_SUFFIX:STRING=""

echo "CMAKE DONE"

:build
mingw32-make
mingw32-make install


cd %TOP%
copy /Y deps_runtime %INSTALL_PREFIX%\bin\


:end
echo "finished"
