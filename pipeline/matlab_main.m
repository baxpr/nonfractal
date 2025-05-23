function matlab_main(inp)

% Verify fmri and mask have same geometry
% FIXME

% Load fmri and reshape
Vfmri = spm_vol(inp.fmri_niigz);
Yfmri = spm_read_vols(Vfmri);
osize = size(Yfmri);
rYfmri = reshape(Yfmri,[],osize(4))';

% Load mask and reshape
Vmask = spm_vol(inp.mask_niigz);
Ymask = spm_read_vols(Vmask);
rYmask = reshape(Ymask,[],1)';

% Find in-mask voxels
keeps = rYmask>0;
nvox = sum(keeps);
mrYfmri = rYfmri(:,keeps);

% Compute Hurst exponent. Break into blocks to avoid memory limits
mrYhurst = zeros(1,nvox);
bksize = 1000;
for startv = 1:bksize:nvox
    inds = startv:min(startv+bksize-1,nvox);
    fprintf('%d %d\n',inds(1),inds(end));
    mrYhurst(inds) = bfn_mfin_ml( ...
        mrYfmri(:,inds), ...
        'filter','haar', ...
        'lb',[-0.5,0], ...
        'ub',[1.5,10], ...
        'verbose',0 ...
        );
end

% Reshape back to image dims
rYhurst = zeros(size(rYmask));
rYhurst(keeps) = mrYhurst;
Yhurst = reshape(rYhurst',osize(1:3));

Vout = rmfield(Vmask,'pinfo');
Vout.fname = fullfile(inp.out_dir,'hurst.nii');
spm_write_vol(Vout,Yhurst);
system(['gzip ' Vout.fname]);

