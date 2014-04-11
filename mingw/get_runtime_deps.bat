set RUNTIME_DEPS_DOWNLOAD_DIR=.\downloads\runtime
set RUNTIME_DEPS_DST_DIR=.\deps_runtime

if not exist %RUNTIME_DEPS_DOWNLOAD_DIR% mkdir %RUNTIME_DEPS_DOWNLOAD_DIR%
if not exist %RUNTIME_DEPS_DST_DIR% mkdir %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo_1.10.2-2_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\cairo_1.10.2-2_win32.zip bin/libcairo-2.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig_2.8.0-2_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\fontconfig_2.8.0-2_win32.zip bin/libfontconfig-1.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libjpeg-6b-4.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libjpeg-6b-4.zip bin/jpeg62.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng_1.4.12-1_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\libpng_1.4.12-1_win32.zip bin/libpng14-14.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libtiff-3.8.2.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\/libtiff-3.8.2.zip bin/libtiff3.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype_2.4.10-1_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\freetype_2.4.10-1_win32.zip bin/freetype6.dll -d %RUNTIME_DEPS_DST_DIR%

wget -nc -P %RUNTIME_DEPS_DOWNLOAD_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/zlib_1.2.5-2_win32.zip
unzip -u -j %RUNTIME_DEPS_DOWNLOAD_DIR%\zlib_1.2.5-2_win32.zip bin/zlib1.dll -d %RUNTIME_DEPS_DST_DIR%

:end
