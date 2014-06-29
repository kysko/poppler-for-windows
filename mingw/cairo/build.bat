@rem echo off

@rem first parameter: branch to build: could be master or any of the listed by "git tag" command. Default is "master"
set CAIRO_BRANCH=%1%

@rem directory where to place product. Default is %TOP%\cairo-install\%TARGET_PLATFORM%\%CAIRO_BRANCH%
set INSTALL_PREFIX=%2%

set CAIRO_BUILD_TOP=.\cairo-build

rem set CAIRO_BRANCH=master

if "%CAIRO_BRANCH%" == "" (
    echo "version is not set!"
    goto :error
)

set CAIRO_BUILD_DIR=%CAIRO_BUILD_TOP%\%CAIRO_BRANCH%

if not exist "%CAIRO_BUILD_DIR%" (
  mkdir "%CAIRO_BUILD_DIR%"
)

@call setenv.bat

@rem setup "INSTALL_PREFIX" if not provided as command line parameter
if "%INSTALL_PREFIX%" == "" set INSTALL_PREFIX=%TOP%\cairo-install

@call get_deps_x86.bat

bash cairo-build.sh %CAIRO_BRANCH%
if %errorlevel% neq 0 (
    echo "cairo-build returned error"
    goto :error
)

goto :end

:error
echo "BUILD FAILED!"
exit /B -1

:end
echo "finished"
cd %TOP%
