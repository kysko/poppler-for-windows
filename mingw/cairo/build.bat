@rem echo off

@rem first parameter: branch to build: could be master or any of the listed by "git tag" command. Default is "master"
@rem set CAIRO_BRANCH=%1%
@rem !currently not user, source code repository should be already checked out with required version

@rem directory where to place product. Default is %TOP%\cairo-install\%TARGET_PLATFORM%\%CAIRO_BRANCH%
@set INSTALL_PREFIX=%2%

@set CAIRO_BUILD_TOP=.\cairo-build

@rem if "%CAIRO_BRANCH%" == "" (
@rem    echo "version is not set!"
@rem    goto :error
@rem )

set CAIRO_BUILD_DIR=%CAIRO_BUILD_TOP%

if not exist "%CAIRO_BUILD_DIR%" (
  mkdir "%CAIRO_BUILD_DIR%"
)

@call setenv.bat

@rem setup "INSTALL_PREFIX" if not provided as command line parameter
@rem if "%INSTALL_PREFIX%" == "" set INSTALL_PREFIX=%TOP%\cairo-install

@call get_deps_x86.bat

sh cairo-build.sh  
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
