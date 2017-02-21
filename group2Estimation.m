function [aveDis, aveAzi] = group2Estimation(R, AZI, Am)
len = length(R);
x = zeros(1, len);
y = zeros(1, len);
d = zeros(1, len);
belta = zeros(1, len);
w = zeros(1, len);
Angle = AZI/180*pi;
for i = 1:len
    x(i) = R(i)*cos(Angle(i));
    y(i) = R(i)*sin(Angle(i));
end
x0 = geomean(x);
y0 = geomean(y);
for i = 1:len
   d(i) = sqrt((x(i) - x0)^2 + (y(i) - y0)^2); 
   belta(i) = exp(-d(i));
end
sumbeltaAM = sum(Am.*belta);
for i = 1:len
   w(i) = belta(i)*Am(i)/sumbeltaAM; 
end
aveX = sum(x.*w);
aveY = sum(y.*w);

aveDis = sqrt(aveX^2 + aveY^2);
aveAngle = atan(aveY/aveX);
aveAzi = aveAngle/pi*180;
end