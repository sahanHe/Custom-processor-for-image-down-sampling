% Image to text conversion

% Read the image from the file
%[filename, pathname] = uigetfile('*.bmp;*.tif;*.jpg;*.pgm','Pick an M-file');
img = imread('lena2.png');
fid = fopen('image.txt','w');

% Image Transpose
imgTrans = img';
% iD conversion
img1D = imgTrans(:);

% Hex value write to the txt file
fprintf(fid, '%d\r\n',img1D);
% Close the txt file
fclose(fid)