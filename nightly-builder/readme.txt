0. Dependencies. It only needs:
0.1 Python 2.7 (Tested with latest 2.7.6)
0.2 Directory "mingw" with scripts from "poppler-for-windows" (<paste URL here>) project


1. Command line options:

1.1 "--config <filename>" - specifies config filename, default is "nightly-builder.conf" in current directory
1.2 "--build <stable|master>", mandatory command line parameter. --build=stable
    or --build=master, for latest stable release or master branch, respectively;

2. Config parameters:

2.1 "root_dir" - specifies directory with build scripts. Should be pointed to "poppler-for-windows/mingw" directory
2.2 "output_root_dir" - specifies root directory where build binaries with runtime dependencies will be created in form: 
    <output_root_dir>/<platform>/<tag_name>, e.g.: <output_root_dir>/x86/poppler-0.26.1. Also it will create zip archives for each build
    under same directory, e.g. : <output_root_dir>/x86/poppler-poppler-0.26.1.zip. 

