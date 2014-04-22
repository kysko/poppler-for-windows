@echo off
call setenv.bat
set PLATFORM=x86

if not exist %TOP%\deps\%PLATFORM% mkdir %TOP%\deps\%PLATFORM%
if not exist %TOP%\downloads\%PLATFORM% mkdir %TOP%\downloads\%PLATFORM%
echo cairo-----------------------------------------------------
if not exist .\deps\%PLATFORM%\cairo (

wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo-dev_1.10.2-2_win32.zip
unzip -u .\downloads\%PLATFORM%\cairo-dev_1.10.2-2_win32.zip -d .\deps\%PLATFORM%\cairo
patch -t --forward -d deps\%PLATFORM%\cairo -p1 < .\patches\cairo.patch

)
echo fontconfig------------------------------------------------
if not exist .\deps\%PLATFORM%\fonfconfig (
wget -nc -P .\downloads\%PLATFORM%  http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig-dev_2.8.0-2_win32.zip
unzip -u .\downloads\%PLATFORM%\fontconfig-dev_2.8.0-2_win32.zip -d .\deps\%PLATFORM%\fontconfig
)

echo freetype--------------------------------------------------
if not exist .\deps\%PLATFORM%\freetype (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype-dev_2.4.10-1_win32.zip
mkdir .\deps\%PLATFORM%\freetype
unzip -u .\downloads\%PLATFORM%\freetype-dev_2.4.10-1_win32.zip -d .\deps\%PLATFORM%\freetype

)

echo libiconv--------------------------------------------------
if not exist .\deps\%PLATFORM%\libiconv (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libiconv-1.9.1.bin.woe32.zip
unzip -u .\downloads\%PLATFORM%\libiconv-1.9.1.bin.woe32.zip -d .\deps\%PLATFORM%\libiconv

)

echo libpng----------------------------------------------------
if not exist .\deps\%PLATFORM%\libpng (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng-dev_1.4.12-1_win32.zip
unzip -u .\downloads\%PLATFORM%\libpng-dev_1.4.12-1_win32.zip -d .\deps\%PLATFORM%\libpng
)

echo zlib------------------------------------------------------
if not exist .\deps\%PLATFORM%\zlib (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/zlib-dev_1.2.5-2_win32.zip
unzip -u .\downloads\%PLATFORM%\zlib-dev_1.2.5-2_win32.zip -d .\deps\%PLATFORM%\zlib
)

echo libjpeg---------------------------------------------------
if not exist .\deps\%PLATFORM%\libjpeg (

wget -nc -P .\downloads\%PLATFORM% sourceforge.net/projects/gnuwin32/files/jpeg/6b-4/jpeg-6b-4-lib.zip
unzip -u .\downloads\%PLATFORM%\jpeg-6b-4-lib.zip -d .\deps\%PLATFORM%\libjpeg

)

echo libtiff---------------------------------------------------
if not exist .\deps\%PLATFORM%\libtiff (

wget -nc -P .\downloads\%PLATFORM% http://sourceforge.net/projects/gnuwin32/files/tiff/3.8.2-1/tiff-3.8.2-1-lib.zip
unzip -u .\downloads\%PLATFORM%\tiff-3.8.2-1-lib.zip -d .\deps\%PLATFORM%\libtiff

)

rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libtiff-dev_3.9.2-1_win32.zip
rem unzip .\downloads\%PLATFORM%\libtiff-dev_3.9.2-1_win32.zip -d .\deps\%PLATFORM%\libtiff

rem :curl
rem echo libcurl---------------------------------------------------
rem if not exist .\deps\%PLATFORM%\libcurl (
rem wget -nc -P .\downloads\%PLATFORM%  http://curl.haxx.se/download/libcurl-7.17.1-win32-nossl.zip
rem unzip -u .\downloads\%PLATFORM%\libcurl-7.17.1-win32-nossl.zip -d .\deps\%PLATFORM%\

rem wget -nc -P .\downloads\%PLATFORM%  http://curl.haxx.se/download/curl-7.36.0.zip
rem unzip -u .\downloads\%PLATFORM%\curl-7.36.0.zip -d .\deps\%PLATFORM%\
rem set CURL_INSTALL_PREFIX=%TOP%\deps\libcurl
rem mkdir %CURL_INSTALL_PREFIX%
rem echo "Changin dir to : " %CURL_INSTALL_PREFIX%
rem cd %CURL_INSTALL_PREFIX%
rem echo %ERRORLEVEL%
rem echo "Curl install prefix: " %CURL_INSTALL_PREFIX%
rem echo "Current dir: " %CD%
rem goto :end
rem bash -c '../curl-7.36.0/configure --prefix=$PWD'
rem bash -c 'make'
rem bash -c 'make install'
rem goto :end
rem )

:lcms
@echo lcms------------------------------------------------------
@rem IMPORTANT! SET doesn't work outside of if ()
SET LCMS2_INSTALL_PREFIX="%TOP%\deps\%PLATFORM%\lcms2"

if not exist .\deps\%PLATFORM%\lcms2-2.4 (
wget -nc -P .\downloads\%PLATFORM% sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.zip

if "%LCMS2_INSTALL_PREFIX%" == "" (
    Echo "Error setting variable"
    goto :end
)

unzip -u .\downloads\%PLATFORM%\lcms2-2.4.zip -d .\deps\%PLATFORM%
@rem Make sure that building lcms is the last step because after build finishes, 
@rem something happened with environment and unzip stops working
mkdir %LCMS2_INSTALL_PREFIX%
cd "%LCMS2_INSTALL_PREFIX%"
bash -c "../lcms2-2.4/configure --prefix=$PWD"
bash -c "make"
bash -c "make install"
)
goto :end


:end
cd %TOP%
