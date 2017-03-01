%%%%%%%%%%%%%%%%%%%%%%%
%%% Author: Chao Li %%%
%%%%%%%%%%%%%%%%%%%%%%%
%随机获得N个目标的若干个点迹
function [R_init, AZI_init, V_init, AM_init, objectSizeinfo] = getUnusalInitObject(objectNum, map_length, map_azi, deltaR, deltaAZI)
vmin = 4;
vmax = 20;
ammin = 150;
ammax = 500;
R_init = []; %目标的初始距离
AZI_init = [];%目标的初始方位
V_init = []; %目标的初始速度
AM_init = [];%目标的幅度信息
maxIndexL = fix(0.8*map_length / deltaR); %随机取的目标的横坐标的最大范围，避免取到边界的极端情况
minIndexL = fix(0.2*map_length / deltaR);
maxIndexAZI = fix(0.8*map_azi / deltaAZI);
minIndexAZI = fix(0.2*map_azi / deltaAZI);
objectSizeinfo = ones(objectNum, 1);
for i = 1:objectNum
    R = randi([minIndexL maxIndexL])*deltaR; %目标的初始横向距离，取运动模型分辨率的整数倍，确定可以整除
    AZI = randi([minIndexAZI maxIndexAZI])*deltaAZI; %目标的初始纵向距离
    V = randi([vmin vmax]); %目标的初始速度
    AM = randi([ammin ammax]);
    width1 = randi([4 5])*deltaR; %目标大小
    length1 = randi([11 15])*deltaR; %目标大小
    
%    fprintf('第%d个目标的信息为(%f, %f, %f, %f)，大小为%d\n', i, R, AZI, V, AM, objectSize*2);
%    objectSizeinfo(i, 1) = 2*objectSize;
    [rinit1, aziinit1, vinit1, aminit1] = getSqurePoints(width1, length1, R, AZI, V, AM, deltaR, deltaAZI);
    [rinit2, aziinit2, vinit2, aminit2] = getSqurePoints(width1, length1, R - length1, AZI, V, AM, deltaR, deltaAZI);
    [rinit3, aziinit3, vinit3, aminit3] = getSqurePoints(length1 + width1 , width1, R - length1/2, AZI + length1/2 + width1/2 , V, AM, deltaR, deltaAZI);
%    pointNum = size(rinit, 1);%该目标的点迹数
    R_init = [R_init; rinit1; rinit2; rinit3];
    AZI_init = [AZI_init; aziinit1; aziinit2; aziinit3];
    V_init = [V_init; vinit1; vinit2; vinit3];
    AM_init = [AM_init; aminit1; aminit2; aminit3];
end
end