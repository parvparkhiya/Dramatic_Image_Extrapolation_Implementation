% function [] = pre_pro_alpha(Ii,Ig,best_translation,maxTxTy,contributor_histogram,patchsz,exstepsz,best_t_count,C,Bgi,s,r,re)

clear;
clc;
close all;
load('temp_result/down_point_5_theatre.mat');



	k1=20;
	uninary_file=fopen(strcat('temp_result/uninary_cost_',num2str(k1),'.txt'),'w');
	smooth_file=fopen(strcat('temp_result/raw_smoothness_cost_',num2str(k1),'.txt'),'w');


	% t1=floor(patchsz/2)+1:exstepsz(1):(size(Ig,1)-ceil(patchsz/2)+1);
	% t2=floor(patchsz/2)+1:exstepsz(2):(size(Ig,2)-ceil(patchsz/2)+1);


	t1=1:size(Ig,1);
	t2=1:size(Ig,2);

	fprintf(uninary_file,'%d %d %d\n',size(t1,2),size(t2,2),best_t_count);
	fprintf(smooth_file,'%d %d %d\n',size(t1,2),size(t2,2),best_t_count);

	total_cost=ones(best_t_count,size(t1,2)*size(t2,2))*1000;

	for i=1:best_t_count

		I_temp=zeros(size(Ig));

		I_temp(Bgi(2):Bgi(2)+Bgi(4)-1,Bgi(1):Bgi(1)+Bgi(3)-1,:)=Ii;

		%imshow(I_temp);
		imwrite(I_temp,strcat('temp_images_alpha/',num2str(k1),'_',num2str(i-1),'.jpg'));
		%waitforbuttonpress;

		for z3=1:3
			for z1=1:size(t1,2)
				for z2=1:size(t2,2)
					fprintf(smooth_file,'%8.6f ',I_temp(t1(z1),t2(z2),z3));
				end
			end
		end
		fprintf(smooth_file,'\n');

		mask=(rgb2gray(I_temp)==0);
		total_cost_im=ones(size(Ig,1),size(Ig,2))*1000;
		total_cost_im=total_cost_im.*mask;


		total_cost(i,:)=reshape(total_cost_im',[1 size(Ig,1)*size(Ig,2)]);

		% for z1=1:size(t1,2)
		% 	for z2=1:size(t2,2)
		% 		if(total_cost(i,(size(t2,2)*(z1-1))+z2)~=0 &&t1(z1)>=sy && t2(z2)>=sx && t1(z1)<sy+Bgi(4) && t2(z2)<sx+Bgi(3))
		% 			total_cost(i,(size(t2,2)*(z1-1))+z2)=C;
		% 		end
		% 	end
		% end

	end

	for i=1:size(total_cost,1)
		fprintf(uninary_file,'%d ',total_cost(i,:));
		fprintf(uninary_file,'\n');
	end



	fclose(uninary_file);
	fclose(smooth_file);

