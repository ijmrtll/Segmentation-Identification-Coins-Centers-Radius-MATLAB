function [centers, radii, metric] = useMatchingCircles(Ima, ~, ~)
N = [];
M = [];
%centers = [];
radii = [];
metric = [];
accumH = Ima;

Dmin = input('What is the value of the minimun diameter Dmin? ' );
Dmax = input('What is the value of the maximun diameter Dmax? ' );

Rmin = floor(Dmin/2);
Rmax = floor(Dmax/2);

range = Rmax:-1:Rmin;
for radi = range
	template = strel('disk', radi);
	accum = normxcorr2(getnhood(template), accumH);
	
	imaSize = size(Ima);
	accumSize = size(accum);
	diff1 = (accumSize(1)-imaSize(1))/2;
	diff2 = (accumSize(2)-imaSize(2))/2;
	accum = accum(diff1:accumSize(1)-diff1 -1, diff2:accumSize(2)-diff2 -1);
	
	[maxx_acc, imax] = max((accum(:)));
	if maxx_acc < -1
		continue
	end
	[ypeak, xpeak] = ind2sub(size(accum), imax(1));
	xpeak = ceil(xpeak);
	ypeak = ceil(ypeak);
	
	if Ima(ypeak,xpeak) == 0
		continue
	end
	
	N = floor(cat(1,N, xpeak));
	M = floor(cat(1,M, ypeak));
	nhood = ceil(radi);
	if ypeak-nhood < 0
		nhood = ypeak-1;
	elseif xpeak-nhood < 0
		nhood = xpeak-1;
	end
	accumH(ypeak-nhood:ypeak+nhood,xpeak-nhood:xpeak+nhood) = 0;
	
end

figure(12)
h = surf(normxcorr2(getnhood(strel('disk', Rmax)), Ima));
set(h, 'edgecolor','none');

centers = [N M];
figure(10); colormap gray
imagesc(uint8(Ima))
hold on
for i=1:size(N)
	plot(centers(i,1),centers(i,2),'g.','MarkerSize',13)
end
hold off
end
