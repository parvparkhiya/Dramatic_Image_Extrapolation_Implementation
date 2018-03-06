function [tranformed_patch,uniform_patch] = compute_transformed_patch(M,patchsz)
	%below code works for both even and odd values of patchsz 
	uniform_patch=zeros(patchsz,patchsz,2);
	tranformed_patch=zeros(patchsz,patchsz,2);
	
	for i=1:patchsz
		for j=1:patchsz
			uniform_patch(i,j,1)=i;
			uniform_patch(i,j,2)=j;
		end
	end
	uniform_patch=uniform_patch-(ceil(patchsz/2)*ones(patchsz,patchsz,2)); % re-centering uniform patch  

	for i=1:patchsz
		for j=1:patchsz
			y=M*[uniform_patch(i,j,1);uniform_patch(i,j,2)];
			tranformed_patch(i,j,1)=y(1);
			tranformed_patch(i,j,2)=y(2);
		end
	end
end