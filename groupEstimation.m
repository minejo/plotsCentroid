function [aveDis aveAzi aveVel] = groupEstimation(R, AZI, V, Am)
len = length(R);
x = zeros(1, len);
y = zeros(1, len);
z = zeros(1, len);
d = zeros(1, len);
belta = zeros(1, len);
w = zeros(1, len);
MaxV = 100;
Vangle = V/MaxV*pi;
for i = 1:len
    x(i) = R(i)*sin(AZI(i))*cos(Vangle(i));
    y(i) = R(i)*sin(AZI(i))*sin(Vangle(i));
    z(i) = R(i)*cos(AZI(i));
end
x0 = geomean(x);
y0 = geomean(y);
z0 = geomean(z);
for i = 1:len
   d(i) = sqrt((x(i) - x0)^2 + (y(i) - y0)^2 + (z(i) - z0)^2); 
   belta(i) = exp(-d(i));
end
sumbeltaAM = sum(Am.*belta);
for i = 1:len
   w(i) = belta(i)*Am(i)/sumbeltaAM; 
end
aveX = sum(x.*w);
aveY = sum(y.*w);
aveZ = sum(z.*w);

aveDis = sqrt(aveX^2 + aveY^2 + aveZ^2);
aveAzi = acos(aveZ/aveDis);
aveVelAngle = atan(aveY/aveX);
aveVel = aveVelAngle / pi * MaxV;
end