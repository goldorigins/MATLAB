%% FILE NAME: background_removal.m

%% CLASS: FALL ME 3060

%% DATE: Sept. 23, 2022

%% AUTHOR: Jacob Branson

%% PURPOSE: 
%  To change background of img from black to white
clc,clear
%% CODE

img = imread('coins.png');%reads in image

black_pxls = img > 80; %any pixel thats black gets a false in logical arry

img(black_pxls==0) = 255; %anytime logic is false change that to white

imshow(img) %show the new image