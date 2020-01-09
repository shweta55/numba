#!/bin/bash

set -v -e

# Install Miniconda
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    if [[ "$BITS32" == "yes" ]]; then
        wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86.sh -O miniconda.sh
    else
        if [[`uname -m ` == 'aarch64']]; then 
            wget -q "https://github.com/Archiconda/build-tools/releases/download/0.2.3/Archiconda3-0.2.3-Linux-aarch64.sh" -O archiconda.sh
        else
            wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
    fi
elif [[ "$unamestr" == 'Darwin' ]]; then
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh
else
  echo Error
fi
if [[`uname -m ` == 'aarch64']]; then 
  chmod +x archiconda.sh
  bash archiconda.sh -b -p $HOME/miniconda
  export PATH="$HOME/miniconda/bin:$PATH"
  sudo cp -r $HOME/miniconda/bin/* /usr/bin/
  hash -r
  sudo conda config --set always_yes yes --set changeps1 no
  sudo conda update -q conda
else
  chmod +x miniconda.sh
  ./miniconda.sh -b
fi
