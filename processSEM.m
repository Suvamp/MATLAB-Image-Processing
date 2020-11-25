% This script will identify minerals on a map and make a grayscale map
%
% processSEM.m
% Written by Suvam S. Patel
% 11/20/2019
%
%--------------------------------------------------------------------------

% load image
iMat = imread('L-8F.jpg');

% Pre-Allocate to white pixels(1)
IronOxide = ones(size(iMat));
Calcite = ones(size(iMat));
Dolomite = ones(size(iMat));
Pores = ones(size(iMat));

% Loop through the rows and cols of the image
[rows, cols]=size(iMat);
countIron = 0;
countCalcite = 0;
countDolomite = 0;
countPores = 0;
for i=1:rows
    for j=1:cols
        if iMat(i,j)>175
            IronOxide(i,j)=0;
            countIron = countIron + 1;
        elseif iMat(i,j)>95 && iMat(i,j)<175
            Calcite(i,j)=0;
            countCalcite = countCalcite + 1;
        elseif iMat(i,j)>61 && iMat(i,j)<94
            Dolomite(i,j)=0;
            countDolomite = countDolomite + 1;
        elseif iMat(i,j)<61
            Pores(i,j)=0;
            countPores = countPores + 1;
        end
    end
end

% plot result
subplot(2,3,1);
imagesc(iMat);
axis('equal','tight');
colormap(gray);
title('RAW image')

subplot(2,3,2);
imagesc(Pores);
axis('equal','tight');
title('Pore space')

subplot(2,3,3);
imagesc(Dolomite);
axis('equal','tight');
title('Dolomite')

subplot(2,3,4);
imagesc(Calcite);
axis('equal','tight');
title('Calcite')

subplot(2,3,5);
imagesc(IronOxide);
axis('equal','tight');
title('Iron Oxides')

% Calculate percentage of each pixel
pctPorosity = (countPores/(countPores + countDolomite + countCalcite + countIron)) * 100;
pctDolomite = (countDolomite/(countPores + countDolomite + countCalcite + countIron)) * 100;
pctCalcite = (countCalcite/(countPores + countDolomite + countCalcite + countIron)) * 100;
pctIronOxide = (countIron/(countPores + countDolomite + countCalcite + countIron)) * 100;
pctTotal = (rows * cols/(countPores + countDolomite + countCalcite + countIron)) * 100;

% Display percentage
fprintf('Pixel Abundances \n');
fprintf('Porosity: %.2f%% \n', pctPorosity);
fprintf('Dolomite: %.2f%% \n', pctDolomite);
fprintf('Calcite: %.2f%% \n', pctCalcite);
fprintf('Iron Oxides: %.2f%% \n', pctIronOxide);
fprintf('Total: %.2f%% \n', pctTotal);
