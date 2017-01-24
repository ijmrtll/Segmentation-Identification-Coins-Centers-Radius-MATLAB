function [centers, radii, metric] = findCircles(Ima, im, names)
%Function to find the centers and radious of a circle using different
%methods
centers = [];
metric = [];
radii = [];
c = 'y';
while(c == 'y')
	flag = false;
	disp ('Types of analysis: ');
	disp (' [0] Cancel/Exit Analysis');
	disp (' [1] Hough Transform Image');
	disp (' [2] Matching Filter');
	disp (' [3] Morphological Filter');
	
	method = input('What type kind of method would you like to use? [0...3]: ');
	
	if lower(input('show imtool for the image? y/n: ','s')) == 'y'
		g = imtool(Ima);
		flag = true;
		pause
	end
	
	switch method
		case 0
			return
		case 1
			[centers, radii, metric] = useHoughCircles(Ima, im, names);
		case 2
			[centers, radii, metric] = useMatchingCircles(Ima, im, names);
		case 3
			[centers, radii, metric] = useMorphologicalCircles(Ima, im, names);
	end
	
	while(true)
		c = lower(input('Would you like to try again? y/n: ','s'));
		if(c == 'y')
			break
		else
			if flag == true
				close(g)
			end
			break
		end
	end
end
end