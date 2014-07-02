@echo off
call setenv.bat
set PLATFORM=x86

if not exist %TOP%\deps\%PLATFORM% mkdir %TOP%\deps\%PLATFORM%
if not exist %TOP%\downloads\%PLATFORM% mkdir %TOP%\downloads\%PLATFORM%

echo freetype--------------------------------------------------
if not exist .\deps\%PLATFORM%\freetype (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/freetype-dev_2.4.10-1_win32.zip
mkdir .\deps\%PLATFORM%\freetype
unzip -u .\downloads\%PLATFORM%\freetype-dev_2.4.10-1_win32.zip -d .\deps\%PLATFORM%\freetype

)

echo libpng----------------------------------------------------
if not exist .\deps\%PLATFORM%\libpng (
rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libpng-dev_1.4.12-1_win32.zip
rem unzip -u .\downloads\%PLATFORM%\libpng-dev_1.4.12-1_win32.zip -d .\deps\%PLATFORM%\libpng
wget -nc -P .\downloads\%PLATFORM%  http://sourceforge.net/projects/ezwinports/files/libpng-1.6.12-w32-bin.zip
unzip -u .\downloads\%PLATFORM%\libpng-1.6.12-w32-bin.zip -d .\deps\%PLATFORM%\libpng
)

echo zlib------------------------------------------------------
if not exist .\deps\%PLATFORM%\zlib (
wget -nc -P .\downloads\%PLATFORM% http://sourceforge.net/projects/ezwinports/files/zlib-1.2.8-2-w32-bin.zip
unzip -u .\downloads\%PLATFORM%\zlib-1.2.8-2-w32-bin.zip  -d .\deps\%PLATFORM%\zlib
)

echo pixman----------------------------------------------------

if not exist .\deps\%PLATFORM%\pixman (
wget -nc -P .\downloads\%PLATFORM% http://sourceforge.net/projects/ezwinports/files/pixman-0.32.4-w32-bin.zip
unzip -u .\downloads\%PLATFORM%\pixman-0.32.4-w32-bin.zip -d .\deps\%PLATFORM%\pixman
)


goto :end

echo cairo-----------------------------------------------------
if not exist .\deps\%PLATFORM%\cairo (
rem wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/cairo-dev_1.10.2-2_win32.zip
rem unzip -u .\downloads\%PLATFORM%\cairo-dev_1.10.2-2_win32.zip -d .\deps\%PLATFORM%\cairo
rem patch -t --forward -d deps\%PLATFORM%\cairo -p1 < .\patches\cairo.patch
rem wget -nc -P .\downloads\%PLATFORM% http://sourceforge.net/projects/ezwinports/files/cairo-1.12.16-w32-bin.zip
rem unzip -u .\downloads\%PLATFORM%\cairo-1.12.16-w32-bin.zip -d .\deps\%PLATFORM%\cairo
)



:end
cd %TOP%
