function feature = compute_featurevector(I, idx, idy, patch_size)
	% Args - 
	%	I - image from which feature vector has to be calculated
	% Returns
	%	feature - a vector containing rgb values and hog features for the patch
	% patch_size = 32;
	Is = imcrop(I, [(idy-floor(patch_size/2)),(idx-floor(patch_size/2)),patch_size-1,patch_size-1]);
	% tR= Is(:,:,1);
	% tG= Is(:,:,2);
	% tB= Is(:,:,3);

	% mR = mean(tR(:));
	% mG = mean(tG(:));
	% mB = mean(tB(:));

	% vR = std(tR(:));
	% vG = std(tG(:));
	% vB = std(tB(:));

	% Is(:,:,1) = (Is(:,:,1)-mR)/vR;
	% Is(:,:,2) = (Is(:,:,2)-mG)/vG;
	% Is(:,:,3) = (Is(:,:,3)-mB)/vB;

	cell_sz=[16 16];
	block_sz=[2 2];
	num_bin=8;
	 
	 % size(Is)

	 % if (size(Is,1)~=patch_size || size(Is,2)~=patch_size)
	 % 	'nothing'
	 % end
	 % disp(idx);
	 % disp(idy);
	% feature = zeros([1 patch_size*patch_size*3]);
	feature = reshape(Is, [1, size(Is,1)*size(Is,2)*size(Is,3)]);
	% feature = [feature, extractHOGFeatures(Is,'BlockSize',block_sz,'CellSize',cell_sz,'NumBins',num_bin)];
	feature = [feature, extractHOGFeatures(Is)];
end
