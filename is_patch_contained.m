function flag = is_patch_contained(tranformed_patch,i_shift,j_shift,i_sz,j_sz)
	flag=0;

	tranformed_patch_i=tranformed_patch(:,:,1);
	tranformed_patch_j=tranformed_patch(:,:,2);
	i_min=min(tranformed_patch_i(:))+i_shift;
	i_max=max(tranformed_patch_i(:))+i_shift;
	j_min=min(tranformed_patch_j(:))+j_shift;
	j_max=max(tranformed_patch_j(:))+j_shift;

	if (i_min>=1 && i_max<=i_sz && j_min>=1 && j_max<=j_sz)
		flag=1;
	end
end