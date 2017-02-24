%%%%%%%%%%%%%%%%%%%%%%%
%%% Author: Chao Li %%%
%%%%%%%%%%%%%%%%%%%%%%%
%随机获得N个目标的若干个点迹
function [R_init, AZI_init, V_init, AM_init, objectSizeinfo] = getRandomInitObject(objectNum, map_length, map_azi, deltaR, deltaAZI)
vmin = 4;
vmax = 10;
ammin = 200;
ammax = 500;
R_init = []; %目标的初始距离
AZI_init = [];%目标的初始方位
V_init = []; %目标的初始速度
AM_init = [];%目标的幅度信息
maxIndexL = fix(0.9*map_length / deltaR); %随机取的目标的横坐标的最大范围，避免取到边界的极端情况
minIndexL = fix(0.1*map_length / deltaR);
maxIndexAZI = fix(0.9*map_azi / deltaAZI);
minIndexAZI = fix(0.1*map_azi / deltaAZI);
objectSizeinfo = ones(objectNum, 1);
for i = 1:objectNum
    R = randi([minIndexL maxIndexL])*deltaR; %目标的初始横向距离，取运动模型分辨率的整数倍，确定可以整除
    AZI = randi([minIndexAZI maxIndexAZI])*deltaAZI; %目标的初始纵向距离
    V = randi([vmin vmax]); %目标的初始速度
    AM = randi([ammin ammax]);
    objectSize = randi([2 9])*deltaR; %目标大小
    objectSizeinfo(i, 1) = 2*objectSize;
    [rinit, aziinit, vinit, aminit] = getRandomPoints(2*objectSize, R, AZI, V, AM, deltaR, deltaAZI);
    pointNum = size(rinit, 1);%该目标的点迹数
    R_init = [R_init; rinit];
    AZI_init = [AZI_init; aziinit];
    V_init = [V_init; vinit];
    AM_init = [AM_init; aminit];
end
end