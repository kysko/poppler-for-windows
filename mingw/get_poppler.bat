call setenv.bat


if not exist %POPPLER_SRC% (
    mkdir %POPPLER_SRC%
    git clone %POPPLER_URL% %POPPLER_SRC%
)

 

@rem wget -nc -P .\arch http://poppler.freedesktop.org/poppler-0.22.0.tar.gz
@rem tar xzf arch\poppler-0.22.0.tar.gz -C src 
@rem patch -t --forward -d src\poppler-0.22.0\ -p1 <poppler-0.22.0.patch
