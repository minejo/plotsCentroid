%定义4个点迹，其中一个为虚假点迹，分别通过改变虚假点击的幅值，距离，角度，来判断新算法对于虚假点的适应性
clear;
close all;
points = [90  10   10   400;
    92  10.2 9.8  405;
    94  10.4 10.2 398;
    97  11   2    500];%[距离 角度 速度 幅度],最后一行为虚假点
R = points(:,1)';
AZI = points(:,2)';
V = points(:,3)';
Am = points(:,4)';
realR = mean(R(1:3));
realAZI = mean(AZI(1:3));
realV = mean(AZI(1:3));
realAm = mean(Am(1:3));
%varrealAm = sum((Am(1:3) - realAm).^2)/3;
%sigma = sqrt(varrealAm);
%% an example
% figure(1);
% 
% [centerDis, centerAzi, centerV] = centerOfMass(R, AZI, V, Am);
% [new2Dis, new2Azi] = group2Estimation(R, AZI, Am);
% [newDis, newAzi, aveVel] = groupEstimation(R, AZI, V, Am);
% plot(R,AZI, '*');
% xlabel('距离R/m');
% ylabel('角度\theta/\circ');
% axis([88.5 102.5 9.5 11.5]);
% hold on;
% plot(centerDis, centerAzi, '^');
% hold on;
% plot(new2Dis, new2Azi, 'ro');
% hold on;
% plot(newDis, newAzi, 'rh');
% legend('原始点迹','质心法','二维加权算法', '三维加权算法');


%% amplitutde variation
deltaA = -200:40:300;
deltaAngleCenter = zeros(1,length(deltaA));
deltaAnglenew2 = zeros(1,length(deltaA));
deltaAnglenew = zeros(1,length(deltaA));
deltaRCenter = zeros(1,length(deltaA));
deltaRnew2 = zeros(1,length(deltaA));
deltaRnew = zeros(1,length(deltaA));
deltaVCenter = zeros(1, length(deltaA));
deltaVnew = zeros(1, length(deltaA));
for i = 1:length(deltaA)
    Am1 = Am;
    Am1(end) = Am1(end) + deltaA(i);
    [centerDis, centerAzi, centerV] = centerOfMass(R, AZI, V, Am1);
    [new2Dis, new2Azi] = group2Estimation(R, AZI, Am1);
    [newDis, newAzi, newV] = groupEstimation(R, AZI, V, Am1);
    deltaAngleCenter(i) = centerAzi - realAZI;
    deltaAnglenew2(i) = new2Azi - realAZI;
    deltaAnglenew(i) = newAzi - realAZI;
    deltaRCenter(i) = centerDis - realR;
    deltaRnew2(i) = new2Dis - realR;
    deltaRnew(i) = newDis - realR;
    deltaVCenter(i) = centerV - realV;
    deltaVnew(i) = newV - realV;
end
figure(2)
plot(deltaA, deltaAngleCenter, '-^');
hold on;
plot(deltaA, deltaAnglenew2, '-*');
hold on;
plot(deltaA, deltaAnglenew, '-ro');
xlabel('\Delta A');
ylabel('\Delta \theta(\circ)');
legend('质心法', '二维加权算法', '三维加权算法');
figure(3)
plot(deltaA, deltaRCenter, '-^');
hold on;
plot(deltaA, deltaRnew2, '-*');
hold on;
plot(deltaA, deltaRnew, '-ro');
xlabel('\Delta A');
ylabel('\Delta R(m)');
legend('质心法', '二维加权算法', '三维加权算法');
figure(4)
plot(deltaA, deltaVCenter, '-*');
hold on;
plot(deltaA, deltaVnew, '-ro');
xlabel('\Delta A');
ylabel('\Delta V(m/s)');
legend('质心法', '三维加权算法');

%% Azimuth Variation
deltaAZI = -5:0.4:5;
deltaAngleCenter = zeros(1,length(deltaAZI));
deltaAnglenew2 = zeros(1,length(deltaAZI));
deltaAnglenew = zeros(1,length(deltaAZI));
deltaRCenter = zeros(1,length(deltaAZI));
deltaRnew2 = zeros(1,length(deltaAZI));
deltaRnew = zeros(1,length(deltaAZI));
deltaVCenter = zeros(1, length(deltaAZI));
deltaVnew = zeros(1, length(deltaAZI));
for i = 1:length(deltaAZI)
    AZI1 = AZI;
    AZI1(end) = AZI1(end) + deltaAZI(i);
    [centerDis, centerAzi, centerV] = centerOfMass(R, AZI1, V, Am);
    [new2Dis, new2Azi] = group2Estimation(R, AZI1, Am);
    [newDis, newAzi, newV] = groupEstimation(R, AZI1, V, Am);
    deltaAngleCenter(i) = centerAzi - realAZI;
    deltaAnglenew2(i) = new2Azi - realAZI;
    deltaAnglenew(i) = newAzi - realAZI;
    deltaRCenter(i) = centerDis - realR;
    deltaRnew2(i) = new2Dis - realR;
    deltaRnew(i) = newDis - realR;
    deltaVCenter(i) = centerV - realV;
    deltaVnew(i) = newV - realV;
end
figure(5)
plot(deltaAZI, deltaAngleCenter, '-^');
hold on;
plot(deltaAZI, deltaAnglenew2, '-*');
hold on;
plot(deltaAZI, deltaAnglenew, '-ro');
xlabel('\Delta \theta_{1}');
ylabel('\Delta \theta(\circ)');
legend('质心法', '二维加权算法', '三维加权算法');
figure(6)
plot(deltaAZI, deltaRCenter, '-^');
hold on;
plot(deltaAZI, deltaRnew2, '-*');
hold on;
plot(deltaAZI, deltaRnew, '-ro');
xlabel('\Delta \theta_{1}');
ylabel('\Delta R(m)');
legend('质心法', '二维加权算法', '三维加权算法');
figure(7)
plot(deltaAZI, deltaVCenter, '-*');
hold on;
plot(deltaAZI, deltaVnew, '-ro');
xlabel('\Delta \theta_{1}');
ylabel('\Delta V(m/s)');
legend('质心法', '三维加权算法');