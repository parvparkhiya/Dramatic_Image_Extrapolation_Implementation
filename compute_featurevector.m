function [feature Is] = compute_featurevector(I, idx, idy, patch_size)
	% Args - 
	%	I - image from which feature vector has to be calculated
	% Returns
	%	feature - a vector containing rgb values and hog features for the patch
	% patch_size = 32;
	Is = imcrop(I, [(idx - floor(patch_size/2)) (idy - floor(patch_size/2)) patch_size-1 patch_size-1]);

	feature = reshape(Is, 1, patch_size*patch_size*3);
end
