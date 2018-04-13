% function [] = pre_pro_alpha(Ii,Ig,best_translation,maxTxTy,contributor_histogram,patchsz,exstepsz,best_t_count,C,Bgi,s,r,re)

clear;
clc;
close all;
load('temp_result/down_point_5_theatre.mat');


[tsort,torder]=sort(num_patches,'descend');
num_transformation_count=20;

lsc=ones(size(scal,2)*size(refl,2)*size(rot,2),1);
lro=ones(size(scal,2)*size(refl,2)*size(rot,2),1);
lre=ones(size(scal,2)*size(refl,2)*size(rot,2),1);
tcount=1;

for i1=1:size(scal,2)
	for i2=1:size(rot,2)
		for i3=1:size(refl,2)
			lsc(tcount)=i1;
			lro(tcount)=i2;
			lre(tcount)=i3;
			tcount=tcount+1;
		end
	end
end

for(k1=0:num_transformation_count-1)
	k1
	uninary_file=fopen(strcat('temp_result/uninary_cost_',num2str(k1),'.txt'),'w');
	smooth_file=fopen(strcat('temp_result/raw_smoothness_cost_',num2str(k1),'.txt'),'w');


	t1=floor(patchsz/2)+1:exstepsz(1):(size(Ig,1)-ceil(patchsz/2)+1);
	t2=floor(patchsz/2)+1:exstepsz(2):(size(Ig,2)-ceil(patchsz/2)+1);

	fprintf(uninary_file,'%d %d %d\n',size(t1,2),size(t2,2),best_t_count);
	fprintf(smooth_file,'%d %d %d\n',size(t1,2),size(t2,2),best_t_count);

	tcontributor_histogram=importdata(strcat('temp_result/contributor_histogram/',num2str(k1+1),'.mat'));

	total_cost=ones(best_t_count,size(t1,2)*size(t2,2))*1000;
	transformation_index=1;
	for i=1:best_t_count
		Tx=floor(best_translation(i,torder(k1+1))/maxTxTy);
		Ty=mod(best_translation(i,torder(k1+1)),maxTxTy);
		% contributors=contributor_histogram{torder(k1+1)}{Tx,Ty};
		contributors=tcontributor_histogram{Tx,Ty};
		for z1=1:size(contributors,1)
			ti=contributors(z1,1);
			tj=contributors(z1,2);
			ti=((ti-(floor(patchsz/2)+1))/exstepsz(1))+1;
			tj=((tj-(floor(patchsz/2)+1))/exstepsz(2))+1;
			total_cost(i,(size(t2,2)*(ti-1))+tj)=0;
		end
		sx=Bgi(1)-(Tx-(floor(maxTxTy/2)+1));
		sy=Bgi(2)-(Ty-(floor(maxTxTy/2)+1));

		for z1=1:size(t1,2)
			for z2=1:size(t2,2)
				if(total_cost(i,(size(t2,2)*(z1-1))+z2)~=0 &&t1(z1)>=sy && t2(z2)>=sx && t1(z1)<sy+Bgi(4) && t2(z2)<sx+Bgi(3))
					total_cost(i,(size(t2,2)*(z1-1))+z2)=C;
				end
			end
		end

		I_temp=zeros(size(Ig));
		Iit=transform_im(Ii,scal(lsc(torder(k1+1))),rot(lro(torder(k1+1))),refl(lre(torder(k1+1))));
		% Iit=transform_im(Ii,1.25,0,0);

		qx=1;
		qy=1;
		qxl=size(Iit,2);
		qyl=size(Iit,1);
		sxl=sx+size(Iit,2)-1;
		syl=sy+size(Iit,1)-1;

		if (sx<1)
			qx=qx+1-sx; %sx is negative
			sx=1;
		end

		if (sy<1)
			qy=qy+1-sy;
	        sy=1;
		end

		if (sxl>size(Ig,2))
			qxl=qxl-(sxl-size(Ig,2));
			sxl=size(Ig,2);
		end

		if (syl>size(Ig,1))
			qyl=qyl-(syl-size(Ig,1));
			syl=size(Ig,1);
		end

		I_temp(sy:syl,sx:sxl,:)=Iit(qy:qyl,qx:qxl,:);

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
	end

	for i=1:size(total_cost,1)
		fprintf(uninary_file,'%d ',total_cost(i,:));
		fprintf(uninary_file,'\n');
	end



	fclose(uninary_file);
	fclose(smooth_file);
end% end
