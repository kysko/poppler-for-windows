""" 
Simple script for automated building popper for Windows (MinGW build)
"""

import sys, argparse, os, ConfigParser, subprocess, re


# global constants and variables
CONFIG_FILENAME="nightly-builder.conf"
CAIRO_SRC_DIR="cairo-src"
BUILD_SCRIPT="build.bat"
GET_CAIRO_SCRIPT="get_cairo.bat"

LATEST_BUILD = "latest_stable_vesion"

config = None
config_filename = CONFIG_FILENAME


def write_default_conf():
    config = ConfigParser.ConfigParser()
    config.add_section("general")
    config.set("general", "root_dir", ".")
    config.set("general", "output_root_dir", ".")
    config.add_section("state")
    config.set("state", LATEST_BUILD, "")
    config.write(open(CONFIG_FILENAME, "w"))
    

def get_latest_stable_version():
    tag_id = subprocess.check_output(["git", "rev-list", "--tags", "--max-count=1"]).rstrip("\n")
    latest_tag = subprocess.check_output(["git", "describe", "--tags", tag_id]).rstrip("\n")
    return latest_tag


def save_state(state):
    if not config.has_section("state"):
        config.add_section("state")
    if LATEST_BUILD in state:
        config.set("state", LATEST_BUILD, state[LATEST_BUILD])
    config.write(open(CONFIG_FILENAME, "w"))


def build_cairo(root_dir, branch, install_top):
    result = True
    install_prefix = install_top + "\\x86" + "\\" + branch
    save_path = os.getcwd()
    
    try:
        os.chdir(root_dir)
        # build
        subprocess.check_call([BUILD_SCRIPT, branch, install_prefix])

    except:
        print "unexpected error :", sys.exc_info()[0]
        result = False
    finally:
        os.chdir(save_path);

    return result

                
                
if __name__ == "__main__":
    
    #  write default config file if not exists
    if not os.path.isfile(CONFIG_FILENAME):
        write_default_conf()

    retval = 0
    # save directory where we started
    startup_dir = os.getcwd()
    parser  = argparse.ArgumentParser()
    parser.add_argument("--config", help="specifies config file name", type=str)
    
    args = parser.parse_args()
    
    
    if args.config:
        config_filename = args.config

    config = ConfigParser.ConfigParser()
    config.read(config_filename)

    root_dir = config.get('general', 'root_dir')
    output_root_dir = config.get('general', 'output_root_dir')
    cairo_src_dir = root_dir + "/" + CAIRO_SRC_DIR
   
    saved_cwd = os.getcwd()

    # check if sources downloaded
    if not os.path.exists(cairo_src_dir):
        os.chdir(root_dir)
        subprocess.check_call([GET_CAIRO_SCRIPT])
    
    os.chdir(cairo_src_dir)

    state = {}
    tag_to_build = ""
    #git_output = subprocess.check_output(["git", "tag", "-l", "cairo-*"])
        # getting latest tags from remote repository
    subprocess.check_call(["git", "fetch", "--tags"]);
    latest_stable_version = get_latest_stable_version()
    # will build only if there's updated version
    if latest_stable_version != config.get("state", LATEST_BUILD) :
        # build it
        tag_to_build = latest_stable_version;
        state[LATEST_BUILD] = latest_stable_version

    if tag_to_build != "":
        print "building ", tag_to_build, "..."

        #changing directory to the root_dir
        os.chdir(saved_cwd)
        os.chdir(root_dir)
        if build_cairo(root_dir, tag_to_build, output_root_dir):
            print "Build successfull.."
            print "saving state", state
            os.chdir(startup_dir)
            save_state(state)
        else:
            print "Build failed."
            retval = 1
    else:
        print "noting to build.."

    os.chdir(saved_cwd)
    sys.exit(retval)
