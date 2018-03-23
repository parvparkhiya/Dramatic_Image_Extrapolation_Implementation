function feature = compute_featurevector(I, idx, idy, patch_size)
	% Args - 
	%	I - image from which feature vector has to be calculated
	% Returns
	%	feature - a vector containing rgb values and hog features for the patch
	% patch_size = 32;
	Is = imcrop(I, [(idy-floor(patch_size/2)+1),(idx-floor(patch_size/2)+1),patch_size-1,patch_size-1]);
	 % size(Is)
	 % disp(idx);
	 % disp(idy);
	feature = reshape(Is, [1, size(Is,1)*size(Is,2)*size(Is,3)]);
end
