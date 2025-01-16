addpath('../m')

% For Mac silicon:
%    Need XCode installed
%
% For all:
%    Need to run wmtsa-matlab-0.2.6/wmtsa/startup.m  to compile
addpath(genpath('../wmtsa-matlab-0.2.6'))

matlab_entrypoint( ...
    'fmri_niigz','../INPUTS/fmri.nii.gz', ...
    'mask_niigz','../INPUTS/mask.nii.gz', ...
    'out_dir', '../OUTPUTS' ...
    );

