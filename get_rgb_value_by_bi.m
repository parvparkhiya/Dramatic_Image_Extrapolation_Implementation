function rgbf = get_rgb_value_by_bi(I, px, py)
	x = [floor(px), ceil(px)];
	y = [floor(py), ceil(py)];

	I = double(I);

	rgbx1 = I(x(1), y(1), :) * (1 - (px - floor(px))) + I(x(2), y(1), :) * (px - floor(px));

	rgbx2 = I(x(1), y(2), :) * (1 - (px - floor(px))) + I(x(2), y(2), :) * (px - floor(px));

	rgbf = rgbx1 * (1 - (py - floor(py))) + rgbx2 * (py - floor(py));
	
end