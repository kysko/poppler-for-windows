@echo off
set PLATFORM=x64
call setenv.bat %PLATFORM%

if not exist %TOP%\deps\%PLATFORM% mkdir %TOP%\deps\%PLATFORM%
if not exist %TOP%\downloads\%PLATFORM% mkdir %TOP%\downloads\%PLATFORM%

echo autoconf--------------------------------------------------
SET AC_INSTALL_PREFIX="%TOP%\deps\%PLATFORM%\autoconf"
if not exist .\deps\%PLATFORM%\autoconf (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnu.org/gnu/autoconf/autoconf-2.68.tar.gz
tar -xf .\downloads\%PLATFORM%\autoconf-2.68.tar.gz -C ./deps/%PLATFORM%/

mkdir %AC_INSTALL_PREFIX%
cd "%AC_INSTALL_PREFIX%"
bash -c "../autoconf-2.68/configure --prefix=$PWD --build=x86_64-w64-mingw32"
bash -c "make"
bash -c "make install"
cd %TOP%
)



echo cairo-----------------------------------------------------
if not exist .\deps\%PLATFORM%\cairo (

wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/cairo-dev_1.10.2-1_win64.zip
unzip -u .\downloads\%PLATFORM%\cairo-dev_1.10.2-1_win64.zip -d .\deps\%PLATFORM%\cairo
patch -t --forward -d deps\%PLATFORM%\cairo -p1 < .\patches\cairo.patch

)
echo fontconfig------------------------------------------------
if not exist .\deps\%PLATFORM%\fonfconfig (
wget -nc -P .\downloads\%PLATFORM%  http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/fontconfig-dev_2.8.0-2_win64.zip
unzip -u .\downloads\%PLATFORM%\fontconfig-dev_2.8.0-2_win64.zip -d .\deps\%PLATFORM%\fontconfig
)

echo freetype--------------------------------------------------
if not exist .\deps\%PLATFORM%\freetype (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/freetype-dev_2.4.4-1_win64.zip
mkdir .\deps\%PLATFORM%\freetype
unzip -u .\downloads\%PLATFORM%\freetype-dev_2.4.4-1_win64.zip -d .\deps\%PLATFORM%\freetype

)

echo libiconv--------------------------------------------------
SET ICONV_INSTALL_PREFIX="%TOP%\deps\%PLATFORM%\libiconv"
if not exist .\deps\%PLATFORM%\libiconv (
@rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/libiconv-1.9.1.bin.woe32.zip
@rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/win-iconv-dev_tml-20100912_win64.zip
@rem unzip -u .\downloads\%PLATFORM%\win-iconv-dev_tml-20100912_win64.zip -d .\deps\%PLATFORM%\libiconv
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.14.tar.gz
mkdir .\deps\%PLATFORM%\libiconv
tar -xf .\downloads\%PLATFORM%\libiconv-1.14.tar.gz -C ./deps/%PLATFORM%/

mkdir %ICONV_INSTALL_PREFIX%
cd "%ICONV_INSTALL_PREFIX%"
bash -c "../libiconv-1.14/configure --prefix=$PWD --build=x86_64-w64-mingw32 --disable-shared"
bash -c "make"
bash -c "make install-strip"
cd %TOP%
)



echo libpng----------------------------------------------------
if not exist .\deps\%PLATFORM%\libpng (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/libpng-dev_1.4.3-1_win64.zip
unzip -u .\downloads\%PLATFORM%\libpng-dev_1.4.3-1_win64.zip -d .\deps\%PLATFORM%\libpng
)

echo zlib------------------------------------------------------
if not exist .\deps\%PLATFORM%\zlib (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/zlib-dev_1.2.5-1_win64.zip
unzip -u .\downloads\%PLATFORM%\zlib-dev_1.2.5-1_win64.zip -d .\deps\%PLATFORM%\zlib
)

echo libjpeg---------------------------------------------------
SET LIBJPEG_INSTALL_PREFIX="%TOP%\deps\%PLATFORM%\libjpeg"
if not exist .\deps\%PLATFORM%\libjpeg (
rem wget -nc -P .\downloads\%PLATFORM% sourceforge.net/projects/gnuwin32/files/jpeg/6b-4/jpeg-6b-4-lib.zip
rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/jpeg-dev_6b-2_win64.zip
rem unzip -u .\downloads\%PLATFORM%\jpeg-dev_6b-2_win64.zip -d .\deps\%PLATFORM%\libjpeg
wget -nc -P .\downloads\%PLATFORM% http://www.ijg.org/files/jpegsr8d.zip
unzip -u .\downloads\%PLATFORM%\jpegsr8d.zip -d .\deps\%PLATFORM%

cd ./deps/%PLATFORM%/jpeg-8d
bash -c "autoheader"
bash -c "autoupdate"
cd %TOP%
mkdir %LIBJPEG_INSTALL_PREFIX%
cd "%LIBJPEG_INSTALL_PREFIX%"
bash -c "../jpeg-8d/configure --prefix=$PWD --build=x86_64-w64-mingw32 --disable-shared"
rem patch -t --forward -d %TOP%\deps\%PLATFORM%\libjpeg -p1 < %TOP%\patches\libjpeg.patch
bash -c "make"
bash -c "make install-strip"
cd %TOP%
goto :end
)

echo libtiff---------------------------------------------------
SET LIBTIFF_INSTALL_PREFIX="%TOP%\deps\%PLATFORM%\libtiff"
if not exist .\deps\%PLATFORM%\libtiff (
rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/jpeg_6b-2_win64.zip
rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win64/dependencies/libtiff-dev_3.8.2-1_win64.zip 
rem unzip -u .\downloads\%PLATFORM%\libtiff-dev_3.8.2-1_win64.zip -d .\deps\%PLATFORM%\libtiff
wget -nc -P .\downloads\%PLATFORM% http://download.osgeo.org/libtiff/tiff-3.9.5.zip
unzip -u .\downloads\%PLATFORM%\tiff-3.9.5.zip -d .\deps\%PLATFORM%

mkdir %LIBTIFF_INSTALL_PREFIX%
cd "%LIBTIFF_INSTALL_PREFIX%"
bash -c "../tiff-3.9.5/configure --prefix=$PWD --host=x86_64-w64-mingw32 --disable-shared"
bash -c "make"
bash -c "make install-strip"
cd %TOP%

)

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
@rem echo PATH=%PATH%
if not exist .\deps\%PLATFORM%\lcms2-2.4 (
wget -nc -P .\downloads\%PLATFORM% sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.zip

if "%LCMS2_INSTALL_PREFIX%" == "" (
    Echo "Error setting variable"
    goto :end
)

unzip -u .\downloads\%PLATFORM%\lcms2-2.4.zip -d .\deps\%PLATFORM%
echo on
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
