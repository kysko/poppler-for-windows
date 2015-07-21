""" 
Simple script for automated building popper for Windows (MinGW build)

"""


import sys, argparse, os, configparser, subprocess, re, locale, shutil


# global constants and variables
CONFIG_FILENAME="nightly-builder.conf"
POPPLER_SRC_DIR="poppler-src"
BUILD_SCRIPT="build.bat"
GET_POPPLER_SCRIPT="get_poppler.bat"

LATEST_STABLE_VERSION = "latest_stable_vesion"
LATEST_MASTER_COMMIT  = "latest_master_commit"

config = None
config_filename = CONFIG_FILENAME
ZIP = "7za.exe"

WPLINK = ""
USERNAME = ""
PASSWORD = ""

def write_default_conf():
    config = configparser.ConfigParser()
    config.add_section("general")
    config.set("general", "root_dir", "../mingw")
    config.set("general", "output_root_dir", "c:\\temp\\poppler-install-dir")
    config.add_section("state")
    config.set("state", LATEST_STABLE_VERSION, "")
    config.set("state", LATEST_MASTER_COMMIT,  "")
    config.write(open(CONFIG_FILENAME, "w"))
    

def get_latest_stable_version():
	#encoding = locale.getdefaultlocale()[1]
    tag_id = subprocess.check_output(["git", "rev-list", "--tags", "--max-count=1"]).decode("utf-8").rstrip("\n")
    latest_tag = subprocess.check_output(["git", "describe", "--tags", tag_id]).decode("utf-8").rstrip("\n")
    return latest_tag

def get_latest_master_commit():
    return subprocess.check_output(["git", "rev-list", "master", "--max-count=1"]).decode("utf-8").strip("\n")

def archive_poppler_build(source_dir, dest_dir):
    saved_cwd = os.getcwd()
    
    try:
        os.chdir(dest_dir)
        #ZIPFILENAME = #os.getcwd() + "\\" +os.path.basename(source_dir) + ".7z"
        args = [ZIP, "a", "-tzip", os.path.basename(source_dir) + ".7z", source_dir]
        print ("compressing poppler with"), args
        subprocess.check_call(args)
    finally:
        os.chdir(saved_cwd)


def save_state(state):
    if not config.has_section("state"):
        config.add_section("state")
    if LATEST_STABLE_VERSION in state:
        config.set("state", LATEST_STABLE_VERSION, state[LATEST_STABLE_VERSION])
    if LATEST_MASTER_COMMIT in state:
        config.set("state", LATEST_MASTER_COMMIT, state[LATEST_MASTER_COMMIT])
    config.write(open(CONFIG_FILENAME, "w"))



def check_dependencies():
    subprocess.check_output([ZIP])

def copyFile(src, dest):
    try:
        shutil.copy(src, dest)
        print(' ===> success file copy : %s' %dest)
    except shutil.Error as e:
        print(' ===> Error : %s' %e)
    except IOError as e:
        print(' ===> Error : %s' %e)

def copyBinaryFiles(save_path, install_prefix):
    copyFile(save_path + "\\poppler-src/AUTHORS", install_prefix + "\\bin" + "/AUTHORS")
    copyFile(save_path + "\\post_build_files/BINARIES", install_prefix + "\\bin" + "/BINARIES")
    copyFile(save_path + "\\poppler-src/COPYING",  install_prefix + "\\bin" + "/COPYING")
    copyFile(save_path + "\\poppler-src/COPYING3",  install_prefix + "\\bin" + "/COPYING3")
    copyFile(save_path + "\\poppler-src/README",  install_prefix + "\\bin" + "/README")
    copyFile(save_path + "\\poppler-src/README-XPDF",  install_prefix + "\\bin" + "/README-XPDF")
    copyFile(save_path + "\\poppler-src/TODO",  install_prefix + "\\bin" + "/TODO")

def fileUploadToWP(ZIPFILEPATH):
    os.chdir(startup_dir)
    os.chdir("../uploadFile")
	

    if WPLINK != "" and USERNAME != "" and PASSWORD != "" and ZIPFILEPATH != "":
        return_code = subprocess.call(["UploadFileToWordpress.exe", WPLINK, USERNAME, PASSWORD, ZIPFILEPATH])
        if return_code == 0:
            print (" ===> Success upload binary file to Wordpress")
        else:
            print (" ===> Fail to upload binary file to Wordpress")
    else:
        print ("You can upload file to wordpress with extra arguments => blog username password")
	
	  
def build_poppler(root_dir, branch, install_top):
    result = True
    install_prefix = install_top + "\\x86" + "\\" + branch
    save_path = os.getcwd()
    
    try:
        os.chdir(root_dir)
        # build
        subprocess.check_call([BUILD_SCRIPT, branch, install_prefix])
        print (save_path)
        print (install_prefix)
		# copy text files to installed dir
        copyBinaryFiles(save_path, install_prefix)
		
		# pack as zip
        archive_poppler_build(install_prefix, install_top + "\\x86")
		
    except:
        print ("unexpected error :"), sys.exc_info()[0]
        result = False
    finally:
        os.chdir(save_path);

    return result

                
                
if __name__ == "__main__":

   
    #  write default config file if not exists

    if not os.path.isfile(CONFIG_FILENAME):
        write_default_conf()

    # save directory where we started
    startup_dir = os.getcwd()
    parser  = argparse.ArgumentParser()
    parser.add_argument("--config", help="specifies config file name", type=str)
    parser.add_argument("--build",  help="specifies build type", type=str, required=True, choices=['stable', 'master'])
    
    #args = parser.parse_args()
    args, options = parser.parse_known_args()
    if len(options) == 3:
        WPLINK = options[0]
        USERNAME = options[1] 
        PASSWORD = options[2]


	
    if args.config:
        config_filename = args.configa

    config = configparser.ConfigParser()
    config.read(config_filename)

    root_dir = config.get('general', 'root_dir')
    output_root_dir = config.get('general', 'output_root_dir')
    poppler_src_dir = root_dir + "/" + POPPLER_SRC_DIR
	
    ZIP = os.path.abspath(root_dir) + "/utils/" + ZIP
    # checking dependencies

    check_dependencies()

    saved_cwd = os.getcwd()

    if not os.path.exists(poppler_src_dir):
        os.chdir(root_dir)
        subprocess.check_call([GET_POPPLER_SCRIPT])
    
    os.chdir(poppler_src_dir)
    
    state = {}
    tag_to_build = ""
    #git_output = subprocess.check_output(["git", "tag", "-l", "poppler-*"])
    if args.build == "stable":
        print (" >>> checking out master")
        subprocess.check_call(["git", "checkout", "master"])
        print (" >>> pulling master..")
        subprocess.check_call(["git", "pull"])
		# getting latest tags from remote repository
        subprocess.check_call(["git", "fetch", "--tags"]);
        latest_stable_version = get_latest_stable_version()
        # will build only if there's updated version
        if latest_stable_version != config.get("state", LATEST_STABLE_VERSION) :
            # build it
            tag_to_build = latest_stable_version;
            state[LATEST_STABLE_VERSION] = latest_stable_version
    elif args.build == "master":
        print (" >>> checking out master")
        subprocess.check_call(["git", "checkout", "master"])
        print (" >>> pulling master..")
        subprocess.check_call(["git", "pull"])
        print (" >>> getting latest master commit..")
        latest_master_commit = get_latest_master_commit()
        # will build only if there's updated version

        if latest_master_commit != config.get("state", LATEST_MASTER_COMMIT):
            tag_to_build = "master"
            state[LATEST_MASTER_COMMIT] = latest_master_commit


    if tag_to_build != "":
        print ("building "), tag_to_build, "..."

        #changing directory to the root_dir
        os.chdir(saved_cwd)
        os.chdir(root_dir)
        if build_poppler(root_dir, tag_to_build, output_root_dir):
            print ("Build successfull..")
            
            zipfilePath	= output_root_dir + "\\x86" + "\\" + tag_to_build + ".7z"
			# FileUpload to wordpress
            print ("uploading 7z file to wordpress....")
            fileUploadToWP(zipfilePath)
            print ("saving state"), state
            os.chdir(startup_dir)
            save_state(state)
			#postBuildAction() #Will run postBuild.exe - whatever that may be (custom) if it's there
    else:
        print ("noting to build..")

    os.chdir(saved_cwd)

