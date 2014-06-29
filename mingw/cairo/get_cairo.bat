@echo off
call setenv.bat

@echo "retrieving cairo sources..."
git clone http://anongit.freedesktop.org/git/cairo %TOP%\cairo-src

:end
cd %TOP%
