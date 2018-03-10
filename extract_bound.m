%function Bgi = extract_bound( )
% Get the bounding box coordinates
Igi=imread('SourceImage/theater1_combi.jpg');
Ig=imread('SourceImage/theater1_guide.jpg');
Ii=imread('SourceImage/theater1_input.jpg');

Rect=zeros(2,2,2);

% 285,91 Top left
% 1796,91 Top right
% 286,1019 Bottom left
% 1796,1019 Bottom right
width=604
height=396
Iiresz=imresize(Ii,[height width]);

imshow(Igi);
figure,imshow(Ig);
%figure,imshow(Ii);
%figure,imshow(Iiresz);
%end

% %function Bgi = extract_bound( )
% % Get the bounding box coordinates
% Igi=imread('SourceImage/gate1_combi.jpg');
% Ig=imread('SourceImage/gate1_guide.jpg');
% Ii=imread('SourceImage/gate1_input.jpg');
% 
% Rect=zeros(2,2,2);
% 
% % 265,392 Top left
% % 1341,392 Top right
% % 266,1106 Bottom left
% % 1341,1106 Bottom right
% width=1075
% height=714
% Iiresz=imresize(Ii,[height width]);
% 
% imshow(Igi);
% figure,imshow(Ig);
% figure,imshow(Ii);
% figure,imshow(Iiresz);
% %end
