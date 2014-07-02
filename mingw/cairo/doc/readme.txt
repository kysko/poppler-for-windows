BUILDING Cairo for Windows with Mingw/MSYS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Preresequities
1.1. MSYS/Mingw installation with packages as described in "popple-for-windows/mingw/doc" 
2. Directory structure
2.1. Static directories:  
  doc/     - documentation, including this file
  utils/   - different utils like patch, wget, unzip, used in build scripts

2.2. Directories created automatically during build
  deps/            - build-time dependencies (*-dev packages)
  downloads/       - directory where all downloaded archives stored
  cairo-build/     - directory where build scripts will do actual build 
  cairo-install/   - directory, where final product will be placed
  cairo-src/       - directory containing cairo git repository, which will be checked out by build script.

2.3 Build scripts
  "cairo-build.sh"      - main build script, do actual work
  "build.bat"           - helper script that setting up environment and calls "cairo-build.sh"
  "nightly-builder.py"  - python script downloads cairo git repository, finds latest stable version and checks out sources for this version. 
                          calls other build scripts to build product.
  "build-cairo.bat"     - launcher that starts python nighly builder.
  "get_deps_x86.bat"    - helper that downloads and prepares development dependencies
  
  "get_cairo.bat"       - helper that creates and updates sources from remote poppler repository
  "setenv.bat"          - contains environment variables, needed for build script. Adjust variables here if you have mingw and git installed in non-default locations.
    
                       
3. Building
This set of scripts is supposed to be used from main poppler build script, but there's nothing preventing to run this scripts
as standalone.
***IMPORTANT*** spaces in path to %TOP% are NOT ALLOWED (build script weren't tested with path containing spaces)

That's all  
