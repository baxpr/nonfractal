#!/usr/bin/env bash

bin/run_matlab_entrypoint.sh \
    /home/rogersbp/MATLAB/R2023a \
    fmri_niigz ../INPUTS/fmri.nii.gz \
    mask_niigz ../INPUTS/mask.nii.gz \
    out_dir ../OUTPUTS

