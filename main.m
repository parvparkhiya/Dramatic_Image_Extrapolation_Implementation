% take image input Ig and Ii
% Ig=double(imread('SourceImage/gate1_guide.jpg'))/255;
% Ii=double(imread('SourceImage/gate1_input.jpg'))/255;
clc;
clear;
Ig=double(imread('SourceImage/theater1_guide.jpg'))/255;
Ii=double(imread('SourceImage/theater1_input.jpg'))/255;

resize_factor=0.5;

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

% Bgi = ceil([265,392,1075,714]*resize_factor); % for gate
% old  Bgi = ceil([285,91,604,396]*resize_factor);  % for theater
Bgi = ceil([141,45,745,458]*resize_factor);  % for theater
Ii = imresize(Ii,[Bgi(4) Bgi(3)]);

% create Igi image from above
Igi = imcrop(Ig,Bgi);

% create discretized values for trans, rot, scaling (
% may consider forming a struct for transformation instead)
scal = linspace(0.5, 2.0, 11);
rot = linspace(-45, 45, 11);
refl = [-1, 1];

patchsz=32;
exstepsz=[16 16];
instepsz=[8 8];
hogsize=324;
K=5;
best_t_count=50;
C=2; 

maxTxTy=(2*ceil(sqrt((size(Ig,1)^2)+(size(Ig,2)^2))))+1;
thresh=100;  %while picking top 5 neartest neighbour

% initialize datastructure to store the best value for each branch
% best_maps = []

% initialize branch index to keep track of branch_num (for indexing of final maps)
b_idx = 0;

best_translation=zeros(best_t_count,size(scal,2)*size(rot,2)*size(refl,2));
num_patches=zeros(size(scal,2)*size(rot,2)*size(refl,2),1);
contributor_histogram=cell(size(scal,2)*size(rot,2)*size(refl,2),1);

% process each branch
tic
for s=1:size(scal,2)
	for r=1:size(rot,2)
		for re=1:size(refl,2)
			b_idx =b_idx+1;
			% do something
			% best_maps[b_idx] = process_branch(Ig, Igi, Ii, scal(s), rot(r), refl(re));
            [best_translation(:,b_idx),num_patches(b_idx),contributor_histogram{b_idx}]=process_branch(Ig, Igi,Bgi, scal(s), rot(r), refl(re),patchsz,exstepsz,instepsz,hogsize,K,thresh,maxTxTy,best_t_count);
          	% remember to change below
          	% remember to change below
          	% remember to change below
          	% remember to change below
          	% remember to change below
          	% remember to change below
            % [best_translation(:,b_idx),num_patches(b_idx),contributor_histogram{b_idx}]=process_branch(Ig, Igi,Bgi, 1.25, 0, 0,patchsz,exstepsz,instepsz,hogsize,K,thresh,maxTxTy,best_t_count);            
            disp(b_idx);
            disp(num_patches(b_idx));
            save('temp_result/down_point_5_theatre.mat');
			% break;
		end
		% break;
	end
	% break;
end
timeis=toc;
disp(timeis);
% perform alpha expansion to get photomontage
%transform_guide_map = get_photo_montage();

% Apply transformations to get final image from Ii
%I = get_image_from_transform_map(transform_guide_map, Ii);

%imshow(I);
%imwrite(I, 'generated_image.png');
