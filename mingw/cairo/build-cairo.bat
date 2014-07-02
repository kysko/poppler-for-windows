@echo off
pushd %~dp0
@call setenv.bat
@call get_deps_x86.bat
python nightly-builder.py
popd
exit /b %ERRORLEVEL%
