#!/bin/bash
#####################################
# Check to see if required packages for NumPy and SciPy are installed || Also NumPy should be installed before SciPY as NumPy is a requirement for SciPy
##############################################################
DEP="gcc gfortran python-dev libblas-dev liblapack-dev cython"
for pkg in $DEP; do
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        echo -e "$pkg is installed"
    elif apt-get -qq install $pkg; then
        echo "Package install successful"
    else 
        echo "Error while installing $pkg"
    fi

# NumPy Package Install
# wget http://archive.ubuntu.com/ubuntu/pool/main/p/python-numpy/python-numpy_1.8.1.orig.tar.gz
