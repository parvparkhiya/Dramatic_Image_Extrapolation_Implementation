function M = computeM(scal,rot,refl)
	R=rotz(rot); % rotation in degree
	M=R(1:2,1:2);
	M=M*(eye(2,2)*scal); % scaling
	if(refl==1)
		M=[1,0; 0,-1]*M; % reflection about x axis (vertical reflection)
	end
end
