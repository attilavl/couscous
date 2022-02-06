#!/bin/bash
# ------------------------------------------------------------------
# [murdock] Coucous installer
#           The vim and bash based dev environment install script
# ------------------------------------------------------------------

VERSION=0.1.0
SUBJECT=alpha
USAGE="Usage: install.sh -ihv args"

# --- Options processing -------------------------------------------
if [ $# == 0 ] ; then
    echo $USAGE
    exit 1;
fi

while getopts ":i:vh" optname
  do
    case "$optname" in
      "v")
        echo "Version $VERSION"
        exit 0;
        ;;
      "i")
        echo "-i argument: $OPTARG"
        ;;
      "h")
        echo $USAGE
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done

shift $(($OPTIND - 1))

param1=$1
param2=$2

# --- Locks -------------------------------------------------------
LOCK_FILE=/tmp/$SUBJECT.lock
if [ -f "$LOCK_FILE" ]; then
   echo "Script is already running"
   exit
fi

trap "rm -f $LOCK_FILE" EXIT
touch $LOCK_FILE


# --- SPECIFIC_VARIABLES ------------------------------------------
#
ISD=/tmp/install_devenv_$USER  # INSTALL_SUPPORT_DIR

# --- Functions ---------------------------------------------------
#

install_prerequisits(){
 bash --version
}


check_system_requirments(){
    bash --version
}


prepare_install_env(){
    mkdir $ISD
    mkdir $ISD/fonts
    mkdir $ISD/starship

    [[ ! -d ~/.fonts ]] && mkdir ~/.fonts
}

delete_install_env(){
    rm -rf $ISD
}
# --- Body --------------------------------------------------------
#  SCRIPT LOGIC GOES HERE
check_system_requirments
install_prerequisits
prepare_install
#INSTALL NERDFONT
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/3270.zip -P $ISD/fonts/
unzip $ISD/fonts/* -d ~/.fonts
fc-cache -fv
# Install starship
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
# Install nvim app image


# Install phatogen
#mkdir -p ~/.vim/autoload ~/.vim/bundle && \
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
#delete_install_env

# -----------------------------------------------------------------
