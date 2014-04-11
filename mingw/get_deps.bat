@echo off
call setenv.bat

if not exist %TOP%\deps mkdir %TOP%\deps
if not exist %TOP%\downloads mkdir %TOP%\downloads

echo cairo-----------------------------------------------------
if not exist .\deps\cairo (
wget -nc -P .\downloads http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo-dev_1.10.2-2_win32.zip
unzip -u .\downloads\cairo-dev_1.10.2-2_win32.zip -d .\deps\cairo
patch -t --forward -d deps\cairo -p1 < .\patches\cairo.patch
)


echo fontconfig------------------------------------------------
if not exist .\deps\fonfconfig (
wget -nc -P .\downloads  http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig-dev_2.8.0-2_win32.zip
unzip -u .\downloads\fontconfig-dev_2.8.0-2_win32.zip -d .\deps\fontconfig
)

echo freetype--------------------------------------------------
if not exist .\deps\freetype (
wget -nc -P .\downloads http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype-dev_2.4.10-1_win32.zip
mkdir .\deps\freetype
unzip -u .\downloads\freetype-dev_2.4.10-1_win32.zip -d .\deps\freetype
)

echo libiconv--------------------------------------------------
if not exist .\deps\libiconv (
wget -nc -P .\downloads http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libiconv-1.9.1.bin.woe32.zip
unzip -u .\downloads\libiconv-1.9.1.bin.woe32.zip -d .\deps\libiconv
)

echo libpng----------------------------------------------------
if not exist .\deps\libpng (
wget -nc -P .\downloads http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng-dev_1.4.12-1_win32.zip
unzip -u .\downloads\libpng-dev_1.4.12-1_win32.zip -d .\deps\libpng
)

echo zlib------------------------------------------------------
if not exist .\deps\zlib (
wget -nc -P .\downloads http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/zlib-dev_1.2.5-2_win32.zip
unzip -u .\downloads\zlib-dev_1.2.5-2_win32.zip -d .\deps\zlib
)

echo libjpeg---------------------------------------------------
if not exist .\deps\libjpeg (
wget -nc -P .\downloads sourceforge.net/projects/gnuwin32/files/jpeg/6b-4/jpeg-6b-4-lib.zip
unzip -u .\downloads\jpeg-6b-4-lib.zip -d .\deps\libjpeg
)

echo libtiff---------------------------------------------------
if not exist .\deps\libtiff (
wget -nc -P .\downloads http://sourceforge.net/projects/gnuwin32/files/tiff/3.8.2-1/tiff-3.8.2-1-lib.zip
unzip -u .\downloads\tiff-3.8.2-1-lib.zip -d .\deps\libtiff
)

rem wget -nc -P .\downloads http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libtiff-dev_3.9.2-1_win32.zip
rem unzip .\downloads\libtiff-dev_3.9.2-1_win32.zip -d .\deps\libtiff

rem :curl
rem echo libcurl---------------------------------------------------
rem if not exist .\deps\libcurl (
rem wget -nc -P .\downloads  http://curl.haxx.se/download/libcurl-7.17.1-win32-nossl.zip
rem unzip -u .\downloads\libcurl-7.17.1-win32-nossl.zip -d .\deps\

rem wget -nc -P .\downloads  http://curl.haxx.se/download/curl-7.36.0.zip
rem unzip -u .\downloads\curl-7.36.0.zip -d .\deps\
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
SET LCMS2_INSTALL_PREFIX="%TOP%\deps\lcms2"

if not exist .\deps\lcms2-2.4 (
wget -nc -P .\downloads sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.zip

if "%LCMS2_INSTALL_PREFIX%" == "" (
    Echo "Error setting variable"
    goto :end
)

unzip -u .\downloads\lcms2-2.4.zip -d .\deps
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


:test_set
set ABS="TEST01"
if "%ABS%" == "" (
    Echo "Error setting ABS variable"
    goto :end
) else (
    Echo "ABS=%ABS%"
)
goto:eof 

:end
cd %TOP%
