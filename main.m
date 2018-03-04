% take image input Ig and Ii
Ig = imread();
Ii = imread();

% take bounding box for rough estimate
% input format [xmin ymin width height]
Bgi = [];

% create Igi image from above
Igi = Imcrop(Ig, Bgi);

% create discretized values for trans, rot, scaling (
% may consider forming a struct for transformation instead)
scal = linspace(0.5, 2.0, 11);
rot = linspace(-45, 45, 11);
refl = [-1, 1];

% initialize datastructure to store the best value for each branch
best_maps = []

% initialize branch index to keep track of branch_num (for indexing of final maps)
b_idx = 0;

% process each branch
for s=scal
	for r=rot
		for re=refl
			b_idx += 1;
			% do something
			best_maps[b_idx] = process_branch(Ig, Igi, Ii, scal, rot, refl);
		end
	end
end

% perform alpha expansion to get photomontage
transform_guide_map = get_photo_montage();

% Apply transformations to get final image from Ii
I = get_image_from_transform_map(transform_guide_map, Ii);

imshow(I);
imwrite(I, 'generated_image.png');
