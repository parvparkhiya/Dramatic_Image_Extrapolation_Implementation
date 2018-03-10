function feature = compute_featurevector(I, transform_matrix, startx, starty, patch_size)
	% Args - 
	%	I - image from which feature vector has to be calculated
	%	transform_matrix - a 2d matrix containing transformed patch
	%	startx - starting x pixel
	%	starty - starting y pixel
	% Returns
	%	feature - a vector containing rgb values and hog features for the patch
	% patch_size = 32;

	feature = [];
	idx = 0;

	Is = zeros(patch_size,patch_size, 3);

	% rounding the transfrom_matrix values to integer. TODO: think how to
	% do bilinear interpolation to get corresponding pixel values instead.
	%transform_matrix = round(transform_matrix);

	for i=1:patch_size
		for j=1:patch_size
			px = transform_matrix(i, j, 1) + startx;
			py = transform_matrix(i, j, 2) + starty;

			feature = [feature, get_rgb_value_by_bi(I, px, py)];
			Is(i, j, :) = get_rgb_value_by_bi(I, px, py);
		end
	end
	% size(feature)

	fet = extractHOGFeatures(Is);
	% size(Is)

	feature = [feature, fet];

end
