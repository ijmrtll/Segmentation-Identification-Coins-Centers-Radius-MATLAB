function [centers, radii, metric] = useMorphologicalCircles(Ima, im, names, ~)

Dmin = input('What is the value of the minimun diameter Dmin? ' );
Dmax = input('What is the value of the maximun diameter Dmax? ' );

Rmin = floor(Dmin/2);
Rmax = floor(Dmax/2);

[centers, radii, metric] = imfindcircles(Ima, [Rmin, Rmax]);
figure(10); colormap gray
imagesc(Ima)
hold on
for i=1:size(radii)
	plot(centers(i,1),centers(i,2),'g.','MarkerSize',10)
end
hold off
viscircles(centers, radii,'Color','b');
title(strcat('Working Image',' # ', num2str(im), ': ', names(im), ' with centers'));
end