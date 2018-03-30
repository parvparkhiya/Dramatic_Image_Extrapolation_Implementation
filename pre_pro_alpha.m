% function [] = pre_pro_alpha(Ii,Ig,best_translation,maxTxTy,contributor_histogram,patchsz,exstepsz,best_t_count,C)
load('temp_result/one_T.mat');

uninary_file=fopen('temp_result/uninary_cost.txt','w');


t1=floor(patchsz/2)+1:exstepsz(1):(size(Ig,1)-ceil(patchsz/2)+1);
t2=floor(patchsz/2)+1:exstepsz(2):(size(Ig,2)-ceil(patchsz/2)+1);

fprintf(uninary_file,'%d %d %d\n',size(t1,2),size(t2,2),best_t_count); 

total_cost=ones(best_t_count,size(t1,2)*size(t2,2))*1000;

for i=best_t_count
	Tx=floor(best_translation(i)/maxTxTy);
	Ty=mod(best_translation(i),maxTxTy);
	contributors=contributor_histogram{Tx,Ty};
	for z1=1:size(contributors,1)
		ti=contributors(z1,1);
		tj=contributors(z1,2);
		ti=((ti-(floor(patchsz/2)+1))/exstepsz(1))+1;
		tj=((tj-(floor(patchsz/2)+1))/exstepsz(2))+1;
		total_cost(i,(size(t1,2)*(ti-1))+tj)=0;
	end	
	
end

fclose(uninary_file);
% end