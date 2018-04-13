function Igi = transform_im(Ig,scal,rot,refl)
	Igi=Ig;
	if (refl==1)
		Igi=Igi(:,end:-1:1,:);
	end
	Igi=imrotate(Igi,rot);
	Igi=imresize(Igi,scal);
end