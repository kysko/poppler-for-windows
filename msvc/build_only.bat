call setenv.bat

call %VS_VARS% x86
cd %POPPLER_BUILD%
msbuild poppler.sln /t:ALL_BUILD /p:Configuration="Release"
vcbuild INSTALL.vcproj /p:Configuration="Release"
