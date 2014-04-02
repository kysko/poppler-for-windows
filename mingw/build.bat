set INSTALL_PREFIX=%CD%\build

call setenv.bat
call get_poppler.bat
call get_deps.bat


if not exist "%POPPLER_BUILD%" (
  mkdir "%POPPLER_BUILD%"
)


cd %POPPLER_BUILD%

rem We should not have MSYS bin dir in path because cmake complains about it when target compiler is Mingw
set PATH=%COMMON_BIN%;%QT_TOP%;%CMAKE_BIN%;%MINGW_BIN%


cmake -G "MinGW Makefiles" %POPPLER_SRC%  ^
  -DCAIRO_INCLUDE_DIR:PATH="%TOP_DEPS%/cairo/include/cairo"^
  -DCAIRO_LIBRARY:FILEPATH="%TOP_DEPS%/cairo/lib/libcairo.dll.a"^
  -DCMAKE_INSTALL_PREFIX="%INSTALL_PREFIX%"^
  -DENABLE_LIBOPENJPEG:BOOL="0" -DPNG_PNG_INCLUDE_DIR:PATH="%TOP_DEPS%/libpng/include"^
  -DFONTCONFIG_INCLUDE_DIR:PATH="%TOP_DEPS%/fontconfig/include"^
  -DFONTCONFIG_LIBRARIES:FILEPATH="%TOP_DEPS%/fontconfig/lib/libfontconfig.dll.a"^
  -DFONT_CONFIGURATION:STRING="win32"^
  -DFREETYPE_INCLUDE_DIR_freetype2:PATH="%TOP_DEPS%/freetype/include/freetype2"^
  -DFREETYPE_INCLUDE_DIR_ft2build:PATH="%TOP_DEPS%/freetype/include"^
  -DFREETYPE_LIBRARY:FILEPATH="%TOP_DEPS%/freetype/lib/libfreetype.dll.a"^
  -DICONV_INCLUDE_DIR:PATH="%TOP_DEPS%/libiconv/include"^
  -DICONV_LIBRARIES:FILEPATH="%TOP_DEPS%/libiconv/lib/libiconv.a"^
  -DJPEG_INCLUDE_DIR:PATH="%TOP_DEPS%/libjpeg/include"^
  -DJPEG_LIBRARY:FILEPATH="%TOP_DEPS%/libjpeg/lib/libjpeg.dll.a"^
  -DLCMS2_INCLUDE_DIR:PATH="%TOP_DEPS%/lcms2-2.4/include"^
  -DLCMS2_LIBRARIES:FILEPATH="%TOP_DEPS%/lcms2-2.4/lib/liblcms2.a"^ -DPKG_CONFIG_EXECUTABLE:FILEPATH="PKG_CONFIG_-NOTFOUND"^
  -DPNG_LIBRARY:FILEPATH="%TOP_DEPS%/libpng/lib/libpng14.dll.a"^
  -DQT_QMAKE_EXECUTABLE="%QT_BIN%/qmake.exe"^
  -DTIFF_INCLUDE_DIR:PATH="%TOP_DEPS%/libtiff/include"^
  -DTIFF_LIBRARY:FILEPATH="%TOP_DEPS%/libtiff/lib/libtiff.dll.a"^
  -DZLIB_INCLUDE_DIR:PATH="%TOP_DEPS%/zlib/include"^
  -DZLIB_LIBRARY:FILEPATH="%TOP_DEPS%/zlib/lib/libz.dll.a"^
  -DLIB_SUFFIX:STRING=""


:build
mingw32-make
mingw32-make install


cd %TOP%
copy /Y deps_runtime %INSTALL_PREFIX%\bin\

