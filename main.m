% take image input Ig and Ii
Ig=double(imread('SourceImage/gate1_guide.jpg'))/255;
Ii=double(imread('SourceImage/gate1_input.jpg'))/255;

resize_factor=0.1;

Ig=imresize(Ig,resize_factor);
Ii=imresize(Ii,resize_factor);
%
% 265,392 Top left
% 1341,392 Top right
% 266,1106 Bottom left
% 1341,1106 Bottom right
% width=1075
% height=714
% take bounding box for rough estimate
% input format [xmin ymin width height]

Bgi = ceil([265,392,1075,714]*resize_factor);

% create Igi image from above
Igi = imcrop(Ig,Bgi);

% create discretized values for trans, rot, scaling (
% may consider forming a struct for transformation instead)
scal = linspace(0.5, 2.0, 11);
rot = linspace(-45, 45, 11);
refl = [-1, 1];

% initialize datastructure to store the best value for each branch
% best_maps = []

% initialize branch index to keep track of branch_num (for indexing of final maps)
b_idx = 0;

% process each branch
for s=1:size(scal,2)
	for r=1:size(rot,2)
		for re=1:size(refl,2)
			b_idx =b_idx+1;
			% do something
			% best_maps[b_idx] = process_branch(Ig, Igi, Ii, scal(s), rot(r), refl(re));
            [best_translation,maxTxTy,num_patches,contributor_histogram]=process_branch(Ig, Igi,Bgi, scal(s), rot(r), refl(re));
			
			break;
		end
		break;
	end
	break;
end

% perform alpha expansion to get photomontage
%transform_guide_map = get_photo_montage();

% Apply transformations to get final image from Ii
%I = get_image_from_transform_map(transform_guide_map, Ii);

%imshow(I);
%imwrite(I, 'generated_image.png');
