@echo off
call setenv.bat
set PLATFORM=x86
set CAIRO_TOP=%TOP%\cairo


if not exist %TOP%\deps\%PLATFORM% mkdir %TOP%\deps\%PLATFORM%
if not exist %TOP%\downloads\%PLATFORM% mkdir %TOP%\downloads\%PLATFORM%
echo cairo with dependencies---------------------------------------------
@rem cairo, freetype, libpng, zlib 
@rem save %TOP%
set SAVE_TOP=%TOP%
pushd %CD%
call %CAIRO_TOP%\build-cairo.bat
popd
echo "after cairo build!! current dir: %CD%"

if %ERRORLEVEL% neq 0 (
    goto :error
)
set TOP=%SAVE_TOP%
@rem after successful cairo build, ther should be
@rem %CAIRO_TOP%\cairo-install -> deps\%PLATFORM%\cairo
@rem %CAIRO_TOP%\deps\%PLATFORM%\freetype -> deps\%PLATFORM%\
@rem %CAIRO_TOP%\deps\%PLATFORM%\libpng   -> deps\%PLATFORM%\
@rem %CAIRO_TOP%\deps\%PLATFORM%\zlib     -> deps\%PLATFORM%\
mkdir %TOP%\deps\%PLATFORM%\cairo > NUL 2>&1
xcopy /Y /E /I %CAIRO_TOP%\cairo-install %TOP%\deps\%PLATFORM%\cairo
xcopy /Y /E /I %CAIRO_TOP%\deps\%PLATFORM%\freetype %TOP%\deps\%PLATFORM%\freetype
xcopy /Y /E /I %CAIRO_TOP%\deps\%PLATFORM%\libpng %TOP%\deps\%PLATFORM%\libpng
xcopy /Y /E /I %CAIRO_TOP%\deps\%PLATFORM%\zlib  %TOP%\deps\%PLATFORM%\zlib
@rem pixman libs and includes actually not needed for builing poppler, only libpixman-1-0.dll
xcopy /Y /E /I %CAIRO_TOP%\deps\%PLATFORM%\pixman %TOP%\deps\%PLATFORM%\pixman
@echo cairo build successful...


echo fontconfig------------------------------------------------
if not exist .\deps\%PLATFORM%\fonfconfig (
wget -nc -P .\downloads\%PLATFORM%  http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/fontconfig-dev_2.8.0-2_win32.zip
unzip -u .\downloads\%PLATFORM%\fontconfig-dev_2.8.0-2_win32.zip -d .\deps\%PLATFORM%\fontconfig
)


echo libiconv--------------------------------------------------
if not exist .\deps\%PLATFORM%\libiconv (
wget -nc -P .\downloads\%PLATFORM% http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/libiconv-1.9.1.bin.woe32.zip
unzip -u .\downloads\%PLATFORM%\libiconv-1.9.1.bin.woe32.zip -d .\deps\%PLATFORM%\libiconv

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

:error
echo downloading/building dependencies failed!
exit /b -1

:end
cd %TOP%
