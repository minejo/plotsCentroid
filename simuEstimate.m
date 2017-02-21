%定义4个点迹，其中一个为虚假点迹，分别通过改变虚假点击的幅值，距离，角度，来判断新算法对于虚假点的适应性
clear;
close all;
points = [90  1   10   400;
          92  1.1 9.8  405;
          94  1.4 10.2 398;
          97  2   30    500];%[距离 角度 速度 幅度],最后一行为虚假点
R = points(:,1)';
AZI = points(:,2)';
V = points(:,3)';
Am = points(:,4)';

figure(1);
[centerDis, centerAzi] = centerOfMass(R, AZI, Am);
[new2Dis, new2Azi] = group2Estimation(R, AZI, Am);
[newDis, newAzi, aveVel] = groupEstimation(R, AZI, V, Am);
plot(R,AZI, '*');
hold on;
% plot(mean(R), mean(AZI), 'd');
% hold on;
plot(centerDis, centerAzi, '^');
hold on;
plot(new2Dis, new2Azi, 'ro');
hold on;
plot(newDis, newAzi, 'rh');
legend('原始点迹','质心法','二维加权算法', '三维加权算法');
axis([88 102 0.5 3]);
xlabel('距离/m');
ylabel('角度/度');