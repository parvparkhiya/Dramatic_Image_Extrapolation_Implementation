function feature = compute_featurevector(I, idx, idy, patch_size)
	% Args - 
	%	I - image from which feature vector has to be calculated
	% Returns
	%	feature - a vector containing rgb values and hog features for the patch
	% patch_size = 32;
	Is = imcrop(I, [(idy-floor(patch_size/2)),(idx-floor(patch_size/2)),patch_size-1,patch_size-1]);
	 % size(Is)

	 % if (size(Is,1)~=patch_size || size(Is,2)~=patch_size)
	 % 	'nothing'
	 % end
	 % disp(idx);
	 % disp(idy);
	feature = zeros([1 patch_size*patch_size*3]);
	% feature = reshape(Is, [1, size(Is,1)*size(Is,2)*size(Is,3)]);
	feature = [feature, extractHOGFeatures(Is)];
end
