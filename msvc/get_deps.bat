wget -nc -P .\arch http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo-dev_1.10.2-2_win32.zip
mkdir .\deps\cairo
unzip -u .\arch\cairo-dev_1.10.2-2_win32.zip -d .\deps\cairo
patch -t --forward -d deps\cairo -p1 < patches\cairo.patch

wget -nc -P .\arch  http://curl.haxx.se/download/libcurl-7.18.0-win32-msvc.zip
mkdir .\deps\libcurl
unzip -u .\arch\libcurl-7.18.0-win32-msvc.zip -d .\deps\libcurl

wget -nc -P .\arch  http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig-dev_2.8.0-2_win32.zip
mkdir .\deps\fontconfig
unzip -u .\arch\fontconfig-dev_2.8.0-2_win32.zip -d .\deps\fontconfig

wget -nc -P .\arch http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype-dev_2.4.10-1_win32.zip
mkdir .\deps\freetype
unzip -u .\arch\freetype-dev_2.4.10-1_win32.zip -d .\deps\freetype

wget -nc -P .\arch http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libiconv-1.9.1.bin.woe32.zip
mkdir .\deps\libiconv
unzip -u .\arch\libiconv-1.9.1.bin.woe32.zip -d .\deps\libiconv

wget -nc -P .\arch sourceforge.net/projects/gnuwin32/files/jpeg/6b-4/jpeg-6b-4-lib.zip
mkdir .\deps\libjpeg
unzip -u .\arch\jpeg-6b-4-lib.zip -d .\deps\libjpeg

rem Start LCMS
	wget -nc -P .\arch sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.zip
	unzip -u .\arch\lcms2-2.4.zip -d .\deps

	call %VS_VARS% x86

	IF EXIST .\deps\lcms2-2.4\Projects\VC%MAX_2010%\lcms2.sln.cache (
		echo.
		echo DELETING UNREQUIRED CACHE FILE - .\deps\lcms2-2.4\Projects\VC%MAX_2010%\lcms2.sln.cache
		del .\deps\lcms2-2.4\Projects\VC%MAX_2010%\lcms2.sln.cache
		echo.
	) 

	msbuild deps\lcms2-2.4\Projects\VC%MAX_2010%\lcms2.sln /t:lcms2_static /p:Configuration=Release
REM END LCMS

rem build static libpng
	wget -nc -P .\arch http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng-dev_1.4.12-1_win32.zip
	mkdir .\deps\libpng
	unzip -u .\arch\libpng-dev_1.4.12-1_win32.zip -d .\deps\libpng

	call setenv.bat
	call %VS_VARS% x86
	msbuild deps\static\libpng\%MAX_2010%\libpng_static.sln /t:libpng /p:Configuration=Release
	copy /Y deps\static\libpng\%MAX_2010%\Release\libpng_static.lib deps\libpng\lib
REM end libpng
	
wget -nc -P .\arch http://sourceforge.net/projects/gnuwin32/files/tiff/3.8.2-1/tiff-3.8.2-1-lib.zip
mkdir .\deps\libtiff
unzip -u .\arch\tiff-3.8.2-1-lib.zip -d .\deps\libtiff

wget -nc -P .\arch http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/zlib-dev_1.2.5-2_win32.zip
mkdir .\deps\zlib
unzip -u .\arch\zlib-dev_1.2.5-2_win32.zip -d .\deps\zlib

rem Recreating zlib library because provided was created in different version of VS
lib /def:deps\zlib\lib\zlib.def /out:deps\zlib\lib\zdll1.lib /machine:x86