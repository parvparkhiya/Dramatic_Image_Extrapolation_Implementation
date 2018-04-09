% global

width = 982;
height = 655;
num_transformations = 1;
num_translations = 50;
patch_size = 32;
exstepsz=[16 16];

in_file = 'temp_result/temp_result.txt';
ifile = fopen(in_file);
labels = textscan(ifile, '%d');
labels = labels{1};
outimage = zeros([height width 3]);
counter = zeros([height width]);

% storing the images for all 50 translations.
im_tranforms = zeros([height width 3 num_transformations num_translations]);


for i = 1:num_transformations
	for j = 1:num_translations
		im_tranforms(:, :, :, i, j) = double(imread(strcat('temp_images_alpha/', num2str(i), '_', num2str(j), '.jpg')))/255;
	end
end

t1=floor(patch_size/2)+1:exstepsz(1):(height-ceil(patch_size/2)+1);
t2=floor(patch_size/2)+1:exstepsz(2):(width-ceil(patch_size/2)+1);

% Right now it considers that label stores only translation for now.
for i = 1:size(t1, 2)
	for j = 1:size(t2,2)
		pixel = (i-1)*size(t2,2) + j;
		py = t1(i) - floor(patch_size/2) + 1;
		px = t2(j) - floor(patch_size/2) + 1;
		outimage(py:py + patch_size - 1, px:px + patch_size - 1, :) = outimage(py:py + patch_size - 1, px:px + patch_size - 1, :) + im_tranforms(py:py + patch_size - 1, px:px + patch_size - 1, :, 1, labels(pixel) + 1);
		counter(py:py + patch_size - 1, px:px + patch_size - 1) = counter(py:py + patch_size - 1, px:px + patch_size - 1) ...
		+ ones([patch_size patch_size]);
	end
end
mask = (counter == 0);
counter = counter + mask;
outimage(:,:,1) = outimage(:,:,1) ./ counter;
outimage(:,:,2) = outimage(:,:,2) ./ counter;
outimage(:,:,3) = outimage(:,:,3) ./ counter;

imshow(outimage);
	
