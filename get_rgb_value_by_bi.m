function rgbf = get_rgb_value_by_bi(I, px, py)
	% Now px and py are 1XN vectors
	x = [floor(px)', ceil(px)'];
	y = [floor(py)', ceil(py)'];

	I = double(I);

	rgbx1 = I(x(:,1), y(:,1), :) .* (ones(size(px)) - (px - floor(px)))' + I(x(:,2), y(:,1), :) .* (px - floor(px))';

	rgbx2 = I(x(:,1), y(:,2), :) .* (ones(size(px)) - (px - floor(px)))' + I(x(:,2), y(:,2), :) .* (px - floor(px))';

	rgbf = rgbx1 .* (ones(size(px)) - (py - floor(py)))' + rgbx2 .* (py - floor(py))';

	rgbf = reshape(rgbf, size(px, 1), 3);
	
end