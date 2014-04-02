call setenv.bat

wget -nc -P .\arch sourceforge.net/projects/lcms/files/lcms/2.4/lcms2-2.4.zip
unzip -u .\arch\lcms2-2.4.zip -d .\deps
pushd
cd .\deps\lcms2-2.4
bash -c './configure --prefix=$PWD'
bash -c 'make'
popd

