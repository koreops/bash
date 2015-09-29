#!/bin/bash
######################################################
# NumPy & SciPy Package Install for Ubuntu 12.04 LTS #
######################################################
# Check to see if required packages for NumPy and SciPy are installed || Also NumPy should be installed before SciPY as NumPy is a requirement for SciPy
# This will install any missing packages to the local environment globally
#
DEP="gcc gfortran python-dev python-setuptools libblas-dev liblapack-dev cython"
for pkg in $DEP; do
    if dpkg --get-selections | grep -q "^$pkg[[:space:]]*install$" >/dev/null; then
        echo -e "$pkg is installed"
    elif apt-get -qq install $pkg; then
        echo "Package install successful"
    else 
        echo "Error while installing $pkg"
    fi
done
# Grab the source file for the NumPY package || Change this as required for different server environments
wget -nc http://archive.ubuntu.com/ubuntu/pool/main/p/python-numpy/python-numpy_1.6.1.orig.tar.gz
tar -zxf python-numpy_1.6.1.orig.tar.gz
##
# Build the .egg package for NumPy
cd numpy-1.6.1 &&
python ./setupegg.py bdist_egg
# Grab source package SciPy
cd .. &&
wget -nc http://archive.ubuntu.com/ubuntu/pool/universe/p/python-scipy/python-scipy_0.9.0+dfsg1.orig.tar.gz
tar -zxf python-scipy_0.9.0+dfsg1.orig.tar.gz
# Build the .egg package for SciPy
cd scipy-0.9.0.orig &&
python ./setupegg.py bdist_egg
#
# The binary .egg files willbe located in the respective dist folders within each extracted directory
