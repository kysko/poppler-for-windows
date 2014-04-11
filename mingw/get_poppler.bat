call setenv.bat


if not exist %POPPLER_SRC% (
    mkdir %POPPLER_SRC%
    git clone %POPPLER_URL% %POPPLER_SRC%
)
 

