@echo off
set PLATFORM=%1
if "%PLATFORM%" == "" SET PLATFORM=x86


set RUNTIME_DEPS_DOWNLOAD_DIR=.\downloads\runtime\%PLATFORM%
set RUNTIME_DEPS_DST_DIR=.\deps_runtime\%PLATFORM%

if not exist %RUNTIME_DEPS_DOWNLOAD_DIR% mkdir %RUNTIME_DEPS_DOWNLOAD_DIR%
if not exist %RUNTIME_DEPS_DST_DIR% mkdir %RUNTIME_DEPS_DST_DIR%


if "%PLATFORM%" == "x86" (
rem wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo_1.10.2-2_win32.zip
rem unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\cairo_1.10.2-2_win32.zip bin/libcairo-2.dll -d %RUNTIME_DEPS_DST_DIR%
copy /Y .\deps\%PLATFORM%\cairo\bin\libcairo-2.dll %RUNTIME_DEPS_DST_DIR%
copy /Y .\deps\%PLATFORM%\libpng\bin\libpng16-16.dll %RUNTIME_DEPS_DST_DIR%
copy /Y .\deps\%PLATFORM%\zlib\bin\zlib1.dll %RUNTIME_DEPS_DST_DIR%
copy /Y .\deps\%PLATFORM%\pixman\bin\libpixman-1-0.dll %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig_2.8.0-2_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\fontconfig_2.8.0-2_win32.zip bin/libfontconfig-1.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libjpeg-6b-4.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libjpeg-6b-4.zip bin/jpeg62.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://sourceforge.net/projects/ezwinports/files/libpng-1.6.7-w32-bin.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libpng-1.6.7-w32-bin.zip bin/libpng16-16.dll -d %RUNTIME_DEPS_DST_DIR%

rem wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng_1.4.12-1_win32.zip
rem unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libpng_1.4.12-1_win32.zip bin/libpng14-14.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libtiff-3.8.2.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\/libtiff-3.8.2.zip bin/libtiff3.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype_2.4.10-1_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\freetype_2.4.10-1_win32.zip bin/freetype6.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/zlib_1.2.5-2_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\zlib_1.2.5-2_win32.zip bin/zlib1.dll -d %RUNTIME_DEPS_DST_DIR%

) else if "%PLATFORM%" == "x64" (

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/cairo_1.10.2-1_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\cairo_1.10.2-1_win64.zip bin/libcairo-2.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/fontconfig_2.8.0-2_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\fontconfig_2.8.0-2_win64.zip bin/libfontconfig-1.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/jpeg_6b-2_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\jpeg_6b-2_win64.zip bin/libjpeg-62.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/libpng_1.4.3-1_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libpng_1.4.3-1_win64.zip bin/libpng14-14.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/libtiff_3.9.1-1_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libtiff_3.9.1-1_win64.zip bin/libtiff.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/freetype_2.4.4-1_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\freetype_2.4.4-1_win64.zip bin/libfreetype-6.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/zlib_1.2.5-1_win64.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\zlib_1.2.5-1_win64.zip bin/zlib1.dll -d %RUNTIME_DEPS_DST_DIR%
)

:end
