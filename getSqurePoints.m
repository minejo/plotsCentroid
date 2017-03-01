%%%%%%%%%%%%%%%%%%%%%%%
%%% Author: Chao Li %%%
%%%%%%%%%%%%%%%%%%%%%%%
%在指定半径内，随机生成若干个随机的点,一个分辨率内只出现一个点
function [rinit, aziinit, vinit, aminit] = getSqurePoints(width1, length1, R, AZI, V, AM, deltaR, deltaAZI)
%radius = objectSize; %物体的半径
rinit = [];
aziinit = [];
vinit = [];
aminit = [];
%aziradius = fix(radius/R*180/pi/2);
for i = R - width1/2:deltaR: R + width1/2
    for j = AZI - length1/2 :deltaAZI: AZI + length1/2
        rinit = [rinit; i];
        aziinit = [aziinit; j];
        vinit = [vinit; V + randi([-1 1])];
        aminit = [aminit; AM + randi([-10 10])];
        
    end
end