function [best_translation num_patches]=process_branch(Ig, Igi,Bgi, scal, rot, refl)
  %computeM where M is transformation matrix
  patchsz=32;
  
  M=computeM(scal,rot,refl); %parv

  %applying M to a uniform patch
  tranformed_patch=compute_transformed_patch(M,patchsz); %parv

  %save feature vectors of all patches in interior of Igi
  for i=1:size(Igi,1)
      for j=1:size(Igi,2)
        if (condition) %if tranformed_patch + (i,j) is contained in Igi
          interior_feature(i,j)=compute_featurevector(Igi,tranformed_patch + (i,j));
        else
          interior_feature(i,j)=NA;
        end
      end
  end

  %iterate over all pixels in Ig - Igi
  for i=1:size(Ig,1)
    for j=1:size(Ig,2)
      if(i<Bgi(1,1) || j<Bgi(1,2) || i>Bgi(2,1) || j>Bgi(2,2))
        feature_vector(i,j)=compute_featurevector(Igi,uniformpatch+(i,j));
        for ii=1:size(Igi,1)
          for jj=1:size(Igi,2)
            temp_delta=l2norm(feature_vector(i,j)-interior_feature(ii,jj));
            if temp_delta<thresh
                  delta_feature_vector=[delta_feature_vector;temp_delta,ii,jj];
            end
          end
        end
      delta_feature_vector=pickbestK(delta_feature_vector); //returns ii jj along with temp_delta
      for kk=1:K
        Tx=Bgi(1,1)+delta_feature_vector(kk,2)-1-i;
        Ty=Bgi(1,2)+delta_feature_vector(kk,3)-1-j;
        Histogram(Tx,Ty)++;
        contributor_histogram(Tx,Ty)=[contributor_histogram(Tx,Ty);i,j];
      end
    end
  end
best_translation=pickindextop50(Histogram);
num_patches=sum(Histogram(best_translation));

end
