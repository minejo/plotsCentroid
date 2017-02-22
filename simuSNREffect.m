clear;
close all;
sita0 = 10; %目标实际方位维10度
dis0 = 100;%目标实际距离为100m
points = 9; %采样点数
sigma = 3;
sita = linspace(9, 11, points);
%dis = linspace(97, 103, points);
dis = ones(1, points)*dis0;
v = ones(1, points)*5;%假设速度都相同为5m/s
am = 3000*normpdf(sita, sita0, sigma);
plot(sita, am, '*');
snr = [5 10 20]; %db
disJuage = 0.3;%距离分辨率为0.3m，带宽为500MHz
deltaSita0 = 1.5; %单程半功率天线波瓣宽度
sita1 = zeros(1, points);
dis1 = zeros(1, points);

deltaSitaCenter = zeros(1, length(snr));
deltaSitaNew2 = zeros(1, length(snr));
deltaSitaNew = zeros(1, length(snr));
deltaRCenter = zeros(1, length(snr));
deltaRnew2 = zeros(1, length(snr));
deltaRnew = zeros(1, length(snr));
%% 数据较为纯净
for k = 1:length(snr)
    sitaResolution = deltaSita0/(1.61*sqrt(2*10^(snr(k)/10))); %测角精度
    disResolution = sqrt(3)*disJuage/(pi*sqrt(2*10^(snr(k)/10)));
    for i = 1:length(sita)
        sita1(i) = getObserveValue(sita(i), sitaResolution);
        %dis1(i) = getObserveValue(dis(i), disResolution);
        dis1 = dis;
    end
    [centerDis, centerAzi, centerV] = centerOfMass(dis1, sita1, v, am);
    [new2Dis, new2Azi] = group2Estimation(dis1, sita1, am);
    [newDis, newAzi, newV] = groupEstimation(dis1, sita1, v, am);
    
    deltaSitaCenter(k) = abs(centerAzi - sita0);
    deltaSitaNew2(k) = abs(new2Azi - sita0);
    deltaSitaNew(k) = abs(newAzi - sita0);
    %deltaRCenter(k) = abs(centerDis - dis0);
    %deltaRnew2(k) = abs(new2Dis - dis0);
    %deltaRnew(k) = abs(newDis - dis0);
end
figure(2);
bar([deltaSitaCenter; deltaSitaNew2; deltaSitaNew]);
%figure(3);
%bar([deltaRCenter; deltaRnew2; deltaRnew]);
%% 少量强杂波
%sita = [sita 
%% 大量弱杂波