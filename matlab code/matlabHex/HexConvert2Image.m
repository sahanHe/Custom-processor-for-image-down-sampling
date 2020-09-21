% Text to image conversion

% % Open the txt file
fid = fopen('inputHex.txt', 'r');
% Scann the txt file 
img = fscanf(fid, '%x', [1 inf]); 
% Close the txt file
fclose(fid) 
% restore the image
outImg = reshape(img,[256 256]);
outImg = outImg';
figure, imshow(outImg,[])