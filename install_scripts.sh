#!/usr/bin/env bash

if [ $# -eq 0 ]
    then
    echo "No arguments supplied"
    echo "Please indicate your CUDA SM compatability version"
    echo "Look up your Compute Compatibility Version for GPU under https://en.wikipedia.org/wiki/CUDA#GPUs_supported"
    echo "Removing the dot between major and minor version yields the SM (System Management) value for the arch flag"
    echo "e. g.:"
    echo ""
    echo "for Tesla K80: install_scripts.sh 37"
    echo "for Tesla P4: install_scripts.sh 61"
fi

cd ./models/FlowNet2_Models/resample2d_package/
bash make.sh $1
cd ../correlation_package
bash make.sh $1
cd ../channelnorm_package
bash make.sh $1
cd ../..