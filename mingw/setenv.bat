set PROGRAM_FILES=%ProgramFiles(x86)%
set TOP=%CD%
set TOP_DEPS=%TOP%\deps
set QT_BIN=c:\Qt\4.8.5-mingw\bin
set POPPLER_URL=git://git.freedesktop.org/git/poppler/poppler
set POPPLER_SRC=%TOP%\poppler-src
set MSYS_BIN=c:\mingw\msys\1.0\bin
set MINGW_BIN=c:\mingw\bin
set CMAKE_BIN="%PROGRAM_FILES%\CMake 2.8\bin"
set GIT_BIN="%PROGRAM_FILES%\Git\bin"
call :setAbsPath  UTILS_PATH %~dp0.\utils
rem set PATH=%UTILS_PATH%;%MSYS_BIN%;%MINGW_BIN%;%CMAKE_BIN%;%GIT_BIN%
set PATH=%MSYS_BIN%;%MINGW_BIN%;%CMAKE_BIN%;%GIT_BIN%;%UTILS_PATH%
goto end

:setAbsPath
  setlocal
  set __absPath=%~f2
  endlocal && set %1=%__absPath%
  goto :eof
::

:end

