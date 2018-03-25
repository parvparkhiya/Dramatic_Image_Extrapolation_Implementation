function [best_translation,maxTxTy,num_patches,contributor_histogram]=process_branch(Ig, Igi,Bgi, scal, rot, refl)
  %computeM where M is transformation matrix
  patchsz=32;
  exstepsz=[16 16];
  instepsz=[8 8];
  hogsize=0;
  K=5


  M=computeM(scal,rot,refl); %parv

  %transform_image
  Igii=transform_im(Igi,scal,rot,refl);

  % [tranformed_patch,uniform_patch]=compute_transformed_patch(M,patchsz); %parv


  % tranformed_patch_i=tranformed_patch(:,:,1);
  % tranformed_patch_j=tranformed_patch(:,:,2);
  % i_min=min(tranformed_patch_i(:));
  % i_max=max(tranformed_patch_i(:));
  % j_min=min(tranformed_patch_j(:));
  % j_max=max(tranformed_patch_j(:));

  %interior_feature=ones(size(Igi,1),size(Igi,2),(patchsz*patchsz*3)+hogsize)*(-1);

  i1=ceil(patchsz/2):instepsz(1):(size(Igii,1)-floor(patchsz/2));
  j1=ceil(patchsz/2):instepsz(2):(size(Igii,2)-floor(patchsz/2));
  interior_feature=zeros(size(i1,2)*size(j1,2),(patchsz*patchsz*3)+hogsize+2);
  %save feature vector(patchsz*patchsz*3)+hogsizes of all patches in interior of Igi
  %NOTE: not considering hog features
  k1=1;
  for i=i1
      for j=j1
        % if (i_min+i>=1 && i_max+i<=size(Igi,1) && j_min+j>=1 && j_max+j<=size(Igi,2)) %if tranformed_patch + (i,j) is contained in Igi
          disp(strcat(num2str(i),'-',num2str(j)));
          % interior_feature(i,j,:)=compute_featurevector(Igi,tranformed_patch,i,j,patchsz);
          %interior_feature(i,j,:)=compute_featurevector(Igii,i,j,patchsz);
          %interior_feature=[interior_feature;[i,j,compute_featurevector(Igii,i,j,patchsz)]];
            interior_feature(k1,:)=[i,j,compute_featurevector(Igii,i,j,patchsz)];
            k1=k1+1;
          % end
      end
  end

  %iterate over all pixels in Ig - Igi
  maxTxTy=(2*ceil(sqrt((size(Ig,1)^2)+(size(Ig,2)^2))))+1;
  thresh=10;  %change threshold
%  feature_vector=zeros(width_Ig,height_Ig,(patchsz*patchsz*3)+hogsize);%change feature_sz
  contributor_histogram=cell(maxTxTy,maxTxTy);
  Histogram=zeros((maxTxTy*maxTxTy),1);

  for i=ceil(patchsz/2)+1:exstepsz(1):(size(Ig,1)-floor(patchsz/2)-1)
    for j=ceil(patchsz/2)+1:exstepsz(2):(size(Ig,2)-floor(patchsz/2)-1)
      delta_feature_vector=[];
      strcat(num2str(i),'-',num2str(j))
      if((i<Bgi(1) || (i>(Bgi(1)+Bgi(3)))) &&( j<Bgi(2) || j>(Bgi(2)+Bgi(4))))
      %  feature_vector(i,j,:)=compute_featurevector(Ig,i,j,patchsz);
        feature_vector=compute_featurevector(Ig,i,j,patchsz);

    %    for ii=1:size(Igi,1)
    %      for jj=1:size(Igi,2)
        for tt=1:size(interior_feature,1)
            %if (interior_feature(ii,jj,1)~=-1)
              temp_delta=norm(feature_vector-interior_feature(tt,3:end));
              ii=interior_feature(tt,1);
              jj=interior_feature(tt,2);
              if (temp_delta<thresh)
                    delta_feature_vector=[delta_feature_vector;[temp_delta,ii,jj]];
              end
            %end
        end
    %      end
    %    end

        %delta_feature_vector=maxk(delta_feature_vector,K,1); //returns ii jj along with temp_delta
       % disp('size');
       % disp(size(delta_feature_vector));
          if(size(delta_feature_vector,1)~=0)
            delta_feature_vector=sortrows(delta_feature_vector,1);
            K1=min(K,size(delta_feature_vector,1));
            delta_feature_vector=delta_feature_vector((end-K1+1):end,:);

            for kk=1:K1
              Tx=Bgi(1)+delta_feature_vector(kk,2)-1-i+floor(maxTxTy/2)+1;
              Ty=Bgi(2)+delta_feature_vector(kk,3)-1-j+floor(maxTxTy/2)+1;
             Histogram((maxTxTy*Tx)+Ty)=Histogram((maxTxTy*Tx)+Ty)+1;
             contributor_histogram{Tx,Ty}=[contributor_histogram{Tx,Ty};i,j];
            end
          end
      end
    end
  end

  %best_translation=maxk(Histogram);
  [~,best_translation]=sort(Histogram,'descend');
  best_translation=best_translation(1:50);
  num_patches=sum(Histogram(best_translation));

end
