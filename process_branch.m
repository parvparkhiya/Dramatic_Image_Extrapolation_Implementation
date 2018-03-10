function [best_translation,maxTxTy,num_patches,contributor_histogram]=process_branch(Ig, Igi,Bgi, scal, rot, refl)
  %computeM where M is transformation matrix
  patchsz=32;

  M=computeM(scal,rot,refl); %parv

  %applying M to a uniform patch
  [tranformed_patch,uniform_patch]=compute_transformed_patch(M,patchsz); %parv


  tranformed_patch_i=tranformed_patch(:,:,1);
  tranformed_patch_j=tranformed_patch(:,:,2);
  i_min=min(tranformed_patch_i(:))+i_shift;
  i_max=max(tranformed_patch_i(:))+i_shift;
  j_min=min(tranformed_patch_j(:))+j_shift;
  j_max=max(tranformed_patch_j(:))+j_shift;

  interior_feature=ones(size(Igi,1),size(Igi,2),(33*33*3)+31)*(-1);

  %save feature vectors of all patches in interior of Igi
  for i=1:size(Igi,1)
      for j=1:size(Igi,2)
        if (i_min+i>=1 && i_max+i<=size(Igi,1) && j_min+j>=1 && j_max+j<=size(Igi,2)) %if tranformed_patch + (i,j) is contained in Igi
          interior_feature(i,j,:)=compute_featurevector(Igi,tranformed_patch,i,j);
        end
      end
  end

  %iterate over all pixels in Ig - Igi
  maxTxTy=ceil(sqrt((size(Igi,1)^2)+(size(Igi,2)^2)));
  width_Ig=size(Ig,1);
  height_Ig=size(Ig,2);
  thresh=1000;  %change threshold
  feature_vector=zeros(width_Ig,height_Ig,feature_sz);%change feature_sz
  contributor_histogram=cell(maxTxTy,maxTxTy);
  Histogram=zeros((maxTxTy*maxTxTy),1);
  for i=1:size(Ig,1)
    for j=1:size(Ig,2)
      delta_feature_vector=[];
      if((i<Bgi(1) || (i>Bgi(1)+Bgi(3)) &&( i>Bgi(2,1) || j>Bgi(2,2))))
        feature_vector(i,j,:)=compute_featurevector(Igi,uniformpatch,i,j);
        for ii=1:size(Igi,1)
          for jj=1:size(Igi,2)
            if (interior_feature(ii,jj,1)~=-1)
              temp_delta=norm(feature_vector(i,j,:)-interior_feature(ii,jj,:));
              if (temp_delta<thresh)
                    delta_feature_vector=[delta_feature_vector;temp_delta,ii,jj];
              end
            end
          end
        end

      %delta_feature_vector=maxk(delta_feature_vector,K,1); //returns ii jj along with temp_delta
      delta_feature_vector=sort(delta_feature_vector,1,'descend');
      delta_feature_vector=delta_feature_vector(1:K,:);

      for kk=1:K
        Tx=Bgi(1)+delta_feature_vector(kk,2)-1-i;
        Ty=Bgi(2)+delta_feature_vector(kk,3)-1-j;
        Histogram((maxTxTy*Tx)+Ty)++;
        contributor_histogram{Tx,Ty}=[contributor_histogram{Tx,Ty};i,j];
      end
    end
  end

%best_translation=maxk(Histogram);
[~,best_translation]=sort(Histogram,'descend');
best_translation=best_translation(1:50);
num_patches=sum(Histogram(best_translation));

end
