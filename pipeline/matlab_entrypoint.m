function matlab_entrypoint(varargin)

% Bail if requested (for dockerfile build)
if strcmp(varargin{1},'quit')
    exit
end

% Parse inputs
P = inputParser;
addOptional(P,'fmri_niigz','/INPUTS/fmri.nii.gz')
addOptional(P,'mask_niigz','/INPUTS/mask.nii.gz')
addOptional(P,'out_dir','/OUTPUTS');
parse(P,varargin{:});
disp(P.Results)

% Run the actual pipeline
matlab_main(P.Results);

% Exit
if isdeployed
	exit
end
