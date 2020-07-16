#!/usr/bin/env bash

unset Root_Version
unset Root_Folder_Surname
unset Developing_Folder
unset CORES
unset Root_Folder_Surname_temp

#Root_Version=5.34.19 # on macBook
# Root_Version=5.34.36 # on macBook
#Root_Version=6.06.00
Root_Version=6.14.06

Root_Folder_Surname="$Root_Version"
Developing_Folder="developing"

CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || sysctl -n hw.ncpu)

# # # # # # # # # # # #
# Defining  Functions #
# # # # # # # # # # # #

yes_or_no()
{
    #Possible argument for yes_or_no
    if [[ $1 =~ ^[yY](es)? ]] ; then
        return 0
    elif [[ $1 =~ ^[nN]o? ]] ; then
        return 1
    fi

    #Promp interaction
    unset yes_or_no_option
    read -p "Type Yes(y) or No(n) `echo $'\n> '`" yes_or_no_option
    if [[ $yes_or_no_option =~ ^[yY](es)? ]] ; then
        return 0
    elif [[ $yes_or_no_option =~ ^[nN]o? ]] ; then
        return 1
    else
        echo "Invalid option!"
        yes_or_no
    fi
}


check_folder()
{
#if [[ -d "root-$Root_Folder_Surname" ]]; then
if [[ -d "${1}/${2}" ]]; then
    echo -e "\n======== !!! Folder ${1}/${2} alredy exist !!! ========\n"
    echo "If you want do delete this folder and proceed the installation?"
    if ( yes_or_no ); then
        rm -ri "${1}/${2}"
        mkdir -p "${1}/${2}" ||  { echo -e "\n!! Wrong choice !!\n" ; check_folder ; }
        return 0
    else
        echo -e "\nCreate new direcotry for the installation ?"
        if ( ! yes_or_no ); then
          exit 1
        fi
        Root_Folder_Surname="${Root_Version}"
        if ( yes_or_no ); then
          echo -e "\nThe name of the folder will be root-${Root_Folder_Surname} plus what you type next."
          read Root_Folder_Surname_temp
          Root_Folder_Surname="${Root_Folder_Surname}""${Root_Folder_Surname_temp}"
          Root_Build_folder="root-${Root_Folder_Surname}"
          mkdir ${Root_Build_folder} ||  { echo -e "\n\n!! Wrong choice !!\n" ; check_folder ; }
          return 0
        fi
    fi
echo "ERROR"
exit 1
else
    mkdir "${Root_Versions_Base_Folder}/${Root_Build_folder}" ||  { echo -e "\n\n!! Wrong choice !!\n" ; check_folder ; }
    return 0
fi
}

check_thisroot()
{
# if function retuns 1, change the dotedfile
if [[ -f ~/"$1" ]]; then
    if ! ( grep -q '^ROOT_FOLDER_VERSION=' ~/"$1" ) && ! ( grep -q '^source.*thisroot.sh$' ~/"$1" ); then return 1 ; fi

    if ( grep -q '^ROOT_FOLDER_VERSION=' ~/"$1" ) && ( grep -q '^source.*thisroot.sh$' ~/"$1" ); then
        echo -e "\n\n===========================================\n"
        echo "Previous instalaton was detected on $1"
        echo -e "Do you want to change the variable ROOT_FOLDER_VERSION on $1 to the current version intalled?\n"
        echo "If yes ~/${1}BKUP will be created"
        if ( yes_or_no ); then
            cp ~/"$1" ~/"$1"BKUP
            sed 's|\(^ROOT_FOLDER_VERSION=\).*|\1'"root-$Root_Folder_Surname|" ~/"$1"BKUP > ~/"$1"
            echo 'source ~'"/$Developing_Folder/$ROOT_FOLDER_VERSION/bin/thisroot.sh"
            source ~/"$1"
            return 0
        fi
    else
        if ! ( grep -q '^ROOT_FOLDER_VERSION=' ~/"$1" ) && ( grep -q '^source.*thisroot.sh$' ~/"$1" ); then
            echo -e "\n\n===========================================\n"
            echo "Previous instalaton was detected on $1"
            echo -e "Do you want to comment the line source.*thisroot.sh on $1 to the current version intalled?\n"
            echo "If yes ~/${1}BKUP will be created"
            if ( yes_or_no ); then
                cp ~/"$1" ~/"$1"BKUP
                sed 's|\(^source.*thisroot.sh$\)|#\1|g' ~/"$1"BKUP > ~/"$1"
                return 1
            fi
        fi
    fi
else
    return 1
fi
}

apend_RootPaths()
{
read -r -d '' Root_Paths <<EOF

#=============== Root =================
ROOT_FOLDER_VERSION="$Root_Build_folder"
ROOTSYS=\$HOME/$Developing_Folder/root/\$ROOT_FOLDER_VERSION
source \$ROOTSYS/bin/thisroot.sh
export ROOTSYS
export PATH=\$PATH:\$ROOTSYS:\$ROOTSYS/bin
export LD_LIBRARY_PATH=\$ROOTSYS/lib:\$LD_LIBRARY_PATH
export DYLD_LIBRARY_PATH=\$ROOTSYS/lib:\$DYLD_LIBRARY_PATH
#======================================
EOF

if (( $# == 0 )); then
  echo "$Root_Paths"
else
  echo "$Root_Paths" >> ~/$1
fi

}



####################
####################
###              ###
###     MAIN     ###
###              ###
####################
####################

echo -e "\n\n==========================================="
echo -e "Root instalation \tVertion $Root_Version"
echo "To change the version abort the scrip and edit the variable Root_Version on this scrip"
echo "Please press return to proceed"
read JUST_PRES_RETURN

    # Go to home !
    cd ~

    # Create roots base folder

    Root_Versions_Base_Folder="$HOME/${Developing_Folder}/root"
    Root_Tar_File="root_v${Root_Version}.source.tar.gz"
    Root_UnTar_Folder="root-${Root_Folder_Surname}_TEMP"
    Root_Build_folder="root-${Root_Folder_Surname}"

    #echo "${Root_Version}"                                  # 5.34.34
    #echo "${Root_Folder_Surname}"                           # 5.34.34
    #echo "$Root_Versions_Base_Folder"                       # /Users/andrereigoto/developing_tst/root
    #echo "$Root_Versions_Base_Folder/$Root_Tar_File"        # /Users/andrereigoto/developing_tst/root/root_v5.34.34.source.tar.gz
    #echo "$Root_Versions_Base_Folder/$Root_UnTar_Folder"    # /Users/andrereigoto/developing_tst/root/root-5.34.34_TEMP
    #echo "$Root_Versions_Base_Folder/$Root_Build_folder"    # /Users/andrereigoto/developing_tst/root/root-5.34.34

    mkdir -p $Root_Versions_Base_Folder

   check_folder $Root_Versions_Base_Folder $Root_Build_folder


    cd $Root_Versions_Base_Folder || { echo -e "\nRoot_Versions_Base_Folder not created\n" ; exit 1 ; }

  if [[ -f $Root_Tar_File ]]; then
    echo "$Root_Tar_File file alredy exist !!"
    echo "Download again the file(yes) or use the one that is on the computer(no)?"
      if ( yes_or_no ); then
        curl -o $Root_Tar_File https://root.cern.ch/download/root_v"${Root_Version}".source.tar.gz  || wget -O $Root_Tar_File https://root.cern.ch/download/root_v"${Root_Version}".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }
      fi
  else
        curl -o $Root_Tar_File https://root.cern.ch/download/root_v"${Root_Version}".source.tar.gz  || wget -O $Root_Tar_File https://root.cern.ch/download/root_v"${Root_Version}".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }
  fi
    # wget -O root_v"$Root_Version".source.tar.gz https://root.cern.ch/download/root_v"$Root_Version".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }
    # curl -o root_v"$Root_Version".source.tar.gz https://root.cern.ch/download/root_v"$Root_Version".source.tar.gz || { echo -e "\nDownload failed\n" ; exit 1 ; }

    echo -e "Root_Version \t\t Root_Folder_Surname"
    echo -e "$Root_Version \t\t\t $Root_Folder_Surname"

    mkdir -p "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
    tar -xf $Root_Tar_File -C $Root_UnTar_Folder --strip-components 1 || { echo -e "\nunTar failed\n" ; exit 1 ; }

    cd $Root_Build_folder


if [[ $OSTYPE =~ "darwin" ]]; then

    echo
    echo "#####################"
    echo "#####################"
    echo "#                   #"
    echo "#        osX        #"
    echo "#                   #"
    echo "#####################"
    echo "#####################"
    echo


    # -- Old method --
    #   "$Root_Versions_Base_Folder/$Root_UnTar_Folder"/configure --prefix="$Root_Versions_Base_Folder/$Root_Build_folder" --enable-roofit --enable-minuit2 --enable-tmva --enable-python || { echo -e "\nConfigure failed\n" ; exit 1 ; }
    #   make all install -j"$CORES" || { echo -e "\nMake install failed!!!\n" ; exit 1 ; }
    # -- Old method --

    # Brew executables in /usr/local/bin
    #export CC='/usr/local/Cellar/gcc/6.2.0/bin/gcc-6'
    #export CXX='/usr/local/Cellar/gcc/6.2.0/bin/g++-6'
    #export FC='/usr/local/Cellar/gcc/6.2.0/bin/gfortran-6'

    #export CC='/usr/local/Cellar/gcc/7.2.0/bin/gcc-7'
    #export CXX='/usr/local/Cellar/gcc/7.2.0/bin/g++-7'
    #export FC='/usr/local/Cellar/gcc/7.2.0/bin/gfortran-7'

    #export CC='/usr/local/Cellar/gcc@4.9/4.9.4/bin/gcc-4.9'
    #export CXX='/usr/local/Cellar/gcc@4.9/4.9.4/bin/g++-4.9'
    #export FC='/usr/local/Cellar/gcc@4.9/4.9.4/bin/gfortran-4.9'

    # Xcode mode
    #export CXX=`xcrun -find c++`
    #export CC=`xcrun -find cc`
    # -Dlibcxx=ON   \

    #export CFLAGS=-I/opt/X11/include
    #export CXXFLAGS=-I/opt/X11/include
    #export CPPFLAGS=-I/opt/X11/include

    if [[ $Root_Version == "5.34.34" ]]; then
      cmake -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" -DGSL_DIR='/usr/local/Cellar/gsl@1/1.16/' -DGSL_CONFIG_EXECUTABLE='/usr/local/Cellar/gsl@1/1.16/bin/gsl-config' "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
    else
      #cmake -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
      #cmake -G Xcode -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
      #cmake -Dcxx17=ON -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
      #cmake -Dcxx14=ON -DCMAKE_C_COMPILER=$CC -DCMAKE_CXX_COMPILER=$CXX -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" "$Root_Versions_Base_Folder/$Root_UnTar_Folder"

      #cmake  -Dminimal=ON

      cmake -Dcxx11=ON    \
            -Droofit=ON   \
            -Dminuit2=ON  \
            -Dtmva=ON     \
            -Dpython=ON   \
            -Dx11=ON      \
            -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
      ccmake "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
    fi

    cmake --build . -- -j"$CORES" || { echo -e "\nMake install failed!!!\n" ; exit 1 ; }

    if      ( check_thisroot ".bashrc" )       ;    then  apend_RootPaths ; apend_RootPaths > "${Root_Versions_Base_Folder}/${Root_Build_folder}-Paths_exemple.txt"; echo -e "Append this info in your bashrc or bach_profile!! \n Exemple in ${Root_Versions_Base_Folder}/${Root_Build_folder}-Paths_exemple.txt"
    elif    ( check_thisroot ".bash_profile" ) ;    then  apend_RootPaths ; apend_RootPaths > "${Root_Versions_Base_Folder}/${Root_Build_folder}-Paths_exemple.txt"; echo -e "Append this info in your bashrc or bach_profile!! \n Exemple in ${Root_Versions_Base_Folder}/${Root_Build_folder}-Paths_exemple.txt"
    else apend_RootPaths ".bash_profile"       ;    echo "Done !!"
    fi

    rm -rf "$Root_Versions_Base_Folder/$Root_UnTar_Folder"

fi



if [[ $OSTYPE =~ "linux-gnu" ]]; then

    echo
    echo "#####################"
    echo "#####################"
    echo "#                   #"
    echo "#       Linux       #"
    echo "#                   #"
    echo "#####################"
    echo "#####################"
    echo

    #Check if packages are installed
    #dpkg-query -W -f='${Package} \t ${Status} ${Version}\n' {git,dpkg-dev,make,g++,gcc,binutils,libx11-dev,libxpm-dev,libxft-dev,libxext-dev}

    #Required packages
    sudo apt-get --yes --force-yes install git dpkg-dev cmake cmake-curses-gui make g++ gcc binutils libx11-dev libxpm-dev libxft-dev libxext-dev

    #Optional packages
    sudo apt-get install gfortran libssl-dev libpcre3-dev \
    xlibmesa-glu-dev libglew1.5-dev libftgl-dev \
    libmysqlclient-dev libfftw3-dev libcfitsio-dev \
    graphviz-dev libavahi-compat-libdnssd-dev \
    libldap2-dev python-dev libxml2-dev libkrb5-dev \
    libgsl0-dev libqt4-dev

    # sudo apt-get --yes --force-yes cfitsio-dev make

    sudo apt-get --yes --force-yes install texlive python-numpy vim

    # -- Old method --
    # #./configure --prefix="$Root_Versions_Base_Folder/$Root_Build_folder" --etcdir="$Root_Versions_Base_Folder/$Root_Build_folder/etc" --all || { echo -e "\nConfigure failed\n" ; exit 1 ; }
    # "$Root_Versions_Base_Folder/$Root_UnTar_Folder"/configure --prefix="$Root_Versions_Base_Folder/$Root_Build_folder" --all || { echo -e "\nConfigure failed\n" ; exit 1 ; }
    # make all install -j"$CORES" || { echo -e "\nMake install failed\n" ; exit 1 ; }
    # -- Old method --

    cmake -Dall=ON -DCMAKE_INSTALL_PREFIX:PATH="$Root_Versions_Base_Folder/$Root_Build_folder" "$Root_Versions_Base_Folder/$Root_UnTar_Folder" || { echo -e "\nConfigure failed\n" ; exit 1 ; }
    cmake --build . -- -j"$CORES" || { echo -e "\nMake install failed!!!\n" ; exit 1 ; }

    if  ( check_thisroot ".bashrc" ) ;  then echo "Done"
    else apend_RootPaths ".bashrc"
    fi

    rm -rf "$Root_Versions_Base_Folder/$Root_UnTar_Folder"
fi
