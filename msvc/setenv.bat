if "%ProgramFiles(x86)%" == "" (
	set PROGRAM_FILES=%ProgramFiles%
) else (
	set PROGRAM_FILES=%ProgramFiles(x86)%
)

set VSHOME=%PROGRAM_FILES%\Microsoft Visual Studio %VS_VERSION%.0
set TOP=%CD%
set TOP_DEPS=%TOP%\deps
set QT_BIN=c:\Qt\4.7.3-msvc2008\bin
set VS_VARS="%VSHOME%\VC\vcvarsall.bat"
set POPPLER_SRC=%TOP%\src\poppler-0.22.0
set POPPLER_BUILD=%TOP%\src\poppler-0.22.0-build
call :setAbsPath  UTILS_PATH %~dp0..\utils\bin
set PATH=%UTILS_PATH%;%PATH%

goto end

:setAbsPath
  setlocal
  set __absPath=%~f2
  endlocal && set %1=%__absPath%
  goto :eof
::

:end

