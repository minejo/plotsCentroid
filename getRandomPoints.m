%%%%%%%%%%%%%%%%%%%%%%%
%%% Author: Chao Li %%%
%%%%%%%%%%%%%%%%%%%%%%%
%在指定半径内，随机生成若干个随机的点,一个分辨率内只出现一个点
function [rinit, aziinit, vinit, aminit] = getRandomPoints(objectSize, R, AZI, V, AM, deltaR, deltaAZI)
radius = objectSize; %物体的半径
rinit = [];
aziinit = [];
vinit = [];
aminit = [];
aziradius = fix(radius/R*180/pi/2);
for i = R - radius:deltaR: R + radius
    for j = AZI - aziradius:deltaAZI: AZI + aziradius
        flag = randi([0 1]);
        if flag == 1
            rinit = [rinit; i];
            aziinit = [aziinit; j];
            vinit = [vinit; V + randi([-2 2])];
            aminit = [aminit; AM + randi([-10 10])];
        end
    end
end