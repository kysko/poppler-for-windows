set PLATFORM=x86
if NOT "%1" == "" SET PLATFORM=%1

set TOP=%~dp0
set PROGRAM_FILES=%ProgramFiles(x86)%
if "%PROGRAM_FILES%" == "" set PROGRAM_FILES=%ProgramFiles%
set TOP_DEPS=%TOP%\deps\%PLATFORM%
rem set QT_BIN=c:\Qt\4.8.5-mingw\bin
set POPPLER_URL=git://git.freedesktop.org/git/poppler/poppler
set POPPLER_SRC=%TOP%\poppler-src
set MSYS_BIN=c:\mingw\msys\1.0\bin
set MINGW_BIN=c:\mingw\bin
set PYTHON_ROOT=c:\Python27
if "%PLATFORM%" == "x64" SET MINGW_BIN=C:\mingw64\mingw64\bin

set CMAKE_BIN="%PROGRAM_FILES%\CMake 2.8\bin"
set GIT_BIN=%PROGRAM_FILES%\Git\cmd
call :setAbsPath  UTILS_PATH %~dp0.\utils
set PATH=%MSYS_BIN%;%MINGW_BIN%;%CMAKE_BIN%;%GIT_BIN%;%UTILS_PATH%;%PYTHON_ROOT%;%SYSTEMROOT%\System32;
goto end

:setAbsPath
  setlocal
  set __absPath=%~f2
  endlocal && set %1=%__absPath%
  goto :eof
::

:end

