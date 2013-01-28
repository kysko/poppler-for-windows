well its hard ot make this work but this is what i did.

1.  install zlib
2.  add the .lib and .h files for zlib to your "path" settings
in Tools->Options (once there->VC++ Directories)
3.  Compile as .lib file and add line


#pragma comment( lib, "libpng.lib" )


to each project that uses it

Look in png.h around line 471, I changed 2 things:

#include <zlib.h> // !! change #1.  make sure ZLIB is installed
// and you have put zlib.h in your VC++ Directories -> include files
#pragma comment ( lib, "zdll.lib" ) // !! change #2.  Make sure ZLIB is installed
// and you have placed "zdll.lib" in VC++ Directories -> Library files.



Good luck.