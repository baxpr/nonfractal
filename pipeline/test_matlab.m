addpath('spm_readwrite_nii')
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

return



%% Misc testing
Vfmri = spm_vol('../INPUTS/fmri.nii.gz');
Yfmri = spm_read_vols(Vfmri);
osize = size(Yfmri);
rYfmri = reshape(Yfmri,[],osize(4))';

% Load mask and reshape
Vmask = spm_vol('../INPUTS/mask.nii.gz');
Ymask = spm_read_vols(Vmask);
rYmask = reshape(Ymask,[],1)';

% Find in-mask voxels
keeps = rYmask>0;
mrYfmri = rYfmri(:,keeps);

%%
nvox = size(mrYfmri,2);
mrYhurst = zeros(1,nvox);
bksize = 100;
for startv = 1%:bksize:nvox
    inds = startv:min(startv+bksize-1,nvox);
    fprintf('%d %d\n',inds(1),inds(end));
    q1 = bfn_mfin_ml( ...
        mrYfmri(:,inds), ...
        'filter','haar', ...
        'lb',[-0.5,0], ...
        'ub',[1.5,10], ...
        'verbose',0 ...
        );
end
