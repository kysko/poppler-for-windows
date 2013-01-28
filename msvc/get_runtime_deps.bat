set DST_DIR=.\arch\runtime

echo jpeg--------------------------------------------------
rem wget -nc -P %DST_DIR% http://gnuwin32.sourceforge.net/downlinks/jpeg-bin-zip.php
wget -nc -P %DST_DIR% sourceforge.net/projects/gnuwin32/files/jpeg/6b-4/jpeg-6b-4-bin.zip/download
unzip -u %DST_DIR%\jpeg*.zip bin\jpeg*.dll -d .\deps_runtime\

echo cairo--------------------------------------------------
wget -nc -P %DST_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo_1.10.2-2_win32.zip
unzip -u %DST_DIR%\cairo_1.10.2-2_win32.zip bin\libcairo-2.dll -d .\deps_runtime

echo fontconfig-----------------------------------------------
wget -nc -P %DST_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig_2.8.0-2_win32.zip
unzip -u %DST_DIR%\fontconfig_2.8.0-2_win32.zip bin\libfontconfig-1.dll -d .\deps_runtime

echo libpng----------------------------------------------
copy .\deps_runtime\static\libexpat-1.dll %INSTALL_PREFIX%\bin\libexpat-1.dll

wget -nc -P %DST_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng_1.4.12-1_win32.zip
unzip -u %DST_DIR%\libpng_1.4.12-1_win32.zip bin\libpng14-14.dll -d .\deps_runtime

echo tiff----------------------------------------------
wget -nc -P %DST_DIR% http://gnuwin32.sourceforge.net/downlinks/tiff-bin-zip.php
unzip -u %DST_DIR%\tiff*.zip bin\libtiff*.dll -d .\deps_runtime\

echo freetype----------------------------------------------
wget -nc -P %DST_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype_2.4.10-1_win32.zip
unzip -u %DST_DIR%\freetype_2.4.10-1_win32.zip bin\freetype6.dll -d .\deps_runtime

echo expat----------------------------------------------
wget -nc -P %DST_DIR% http://sourceforge.net/projects/expat/files/expat_win32/2.0.1/expat-win32bin-2.0.1.exe

echo zlib----------------------------------------------
wget -nc -P %DST_DIR% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/zlib_1.2.5-2_win32.zip
unzip -u %DST_DIR%\zlib_1.2.5-2_win32.zip bin\zlib1.dll -d .\deps_runtime

REM cleanup unzip filestructures
copy .\deps_runtime\bin\*.dll %INSTALL_PREFIX%\bin\*.dll
del /Q .\deps_runtime\bin\*.*
rd .\deps_runtime\bin