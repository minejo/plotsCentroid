%function [class, type] = traCentroid(data, resolutionR, resolutionAzi, deltafd, deltaA)
%for test
% data = [28    50    76    96;
%     29    51    76    96;
%     68    52    26    55;
%     66    35    51    14;
%     17    59    70    15;
%     12    23    90    26];
% [R_init, AZI_init, V_init, AM_init, objectSizeinfo] = getRandomInitObject(2, 100, 90, 1, 1);
% data = [R_init AZI_init V_init AM_init];
% plot(AZI_init,R_init, '*');
% axis([0 100 0 100]);
% ylabel('距离/m');
% xlabel('方位角/度');
% resolutionR = 5;
% resolutionAzi = 2;
% deltafd = 30;
% deltaA = 20;
% save config.mat
load('config.mat');
%
disAxis = min(data(:,1)):resolutionR: max(data(:,1));
angleAxis = min(data(:,2)):resolutionAzi:max(data(:,2));
aziGroup = cell(1, length(angleAxis)+1);
aziGroup2 = cell(1, length(angleAxis)+1);
orginGroup2 = cell(1, length(angleAxis)+1);
data = sortrows(data,2);
for i = 1:size(data,1)
    k = ceil(data(i, 2) / resolutionAzi) - ceil(data(1, 2) / resolutionAzi) + 1;
    aziGroup{k} = [aziGroup{k}; data(i, :)];
end
%同方位的距离向凝聚
for i = 1:length(aziGroup)
    if(~isempty(aziGroup{i}))
        [aziGroup2{i}, orginGroup2{i}] = listCombine(aziGroup{i}, resolutionR, deltafd, deltaA, resolutionAzi );
    end
end
%相邻方向向的凝聚
combineGroup = aziGroup2{1};
orginCombineGroup = orginGroup2{1};
if length(angleAxis) > 1
    for i = 2:length(angleAxis) - 1
        len = size(aziGroup2{i},1);
        for k = 1:len
            flag = 0;
            for j = 1:length(combineGroup)
              if (abs(aziGroup2{i}(k,1)-combineGroup(j,1))<abs(0.5*(aziGroup2{i}(k,5)-combineGroup(j,5))))
                  %[combineGroup(j,:) = listCombine(orginGroup2{i}{k}
                  twogroup = [orginGroup2{i}{k}; orginCombineGroup{j}];
                  [centerDis, centerAzi, centerV] = centerOfMass(twogroup(:,1), twogroup(:,2), twogroup(:,3), twogroup(:,4));
                  combineGroup(j,:) = [centerDis centerAzi centerV mean(twogroup(:,4)) max(twogroup(:,1)) - min(twogroup(:,1)) max(twogroup(:,2)) - min(twogroup(:,2))];
                  orginCombineGroup{j} = twogroup;
                  flag = 1;
                  break;
              end
            end
            if flag == 0
                combineGroup = [combineGroup;  aziGroup2{i}(k,:)];
            end
        end
    end
end
