#!/usr/bin/env bash

docker run \
    --mount type=bind,src=$(pwd -P)/INPUTS,dst=/INPUTS \
    --mount type=bind,src=$(pwd -P)/OUTPUTS,dst=/OUTPUTS \
    nonfractal:test \
    fmri_niigz /INPUTS/fmri.nii.gz \
    mask_niigz /INPUTS/mask.nii.gz \
    out_dir /OUTPUTS
