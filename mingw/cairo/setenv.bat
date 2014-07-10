set TOP=%~dp0
set PROGRAM_FILES=%ProgramFiles(x86)%
if "%PROGRAM_FILES%" == "" set PROGRAM_FILES=%ProgramFiles%
set TOP_DEPS=%TOP%\deps
rem set QT_BIN=c:\Qt\4.8.5-mingw\bin
set MSYS_BIN=c:\mingw\msys\1.0\bin
set MINGW_BIN=c:\mingw\bin
set CAIRO_URL=git clone http://anongit.freedesktop.org/git/cairo
set CAIRO_SRC=%TOP%\cairo-src
set PYTHON_ROOT=c:\Python27

set GIT_BIN=%PROGRAM_FILES%\Git\cmd
call :setAbsPath  UTILS_PATH %~dp0.\utils
set PATH=%SYSTEMROOT%\System32;%MSYS_BIN%;%MINGW_BIN%;%GIT_BIN%;%UTILS_PATH%;%PYTHON_ROOT%
goto end

:setAbsPath
  setlocal
  set __absPath=%~f2
  endlocal && set %1=%__absPath%
  goto :eof
::

:end

