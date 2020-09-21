delete(instrfind);
clear all;
close all;
clc;
image=imread('lena.bmp');
dest_image=zeros(256,256,'uint8');
sObject=serial('COM6','BaudRate',115200,'Terminator','LF','TimeOut',20);
%sObject=serial('COM7','baudrate',115200,'databits',8,'parity','none','stopbits',1,'readasyncmode','continuous');
fopen(sObject);
for i=1:256
    for j=1:256
       fwrite(sObject,image(i,j,1));
    end  
end
fwrite(sObject,0);
fwrite(sObject,0);
%fwrite(sObject,0);

dest_image(1,1)=fread(sObject,1,'uint8');
%dest_image(1,1)=fread(sObject,1,'uint8');
%dest_image(1,1)=fread(sObject,1,'uint8');
for i=1:256
    for j=1:256
        dest_image(i,j)=fread(sObject,1,'uint8');
    end  
end
fclose(sObject);
dest_image=uint8(dest_image);
imshow(dest_image);

down_sampled_image=zeros(128,128,'uint8');
for i=1:128
    for j=1:128
        down_sampled_image(i,j)=dest_image(i,j);
    end  
end
%imshow(down_sampled_image);
        