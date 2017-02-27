function combineGroup = traCentroid(data, AM_init)
data = [data AM_init];
resolutionR = 3;
resolutionAzi = 3;
deltafd = 4;
deltaA = 30;
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
for i = 1:size(aziGroup,2)
    if(~isempty(aziGroup{i}))
        [aziGroup2{i}, orginGroup2{i}] = listCombine(aziGroup{i}, resolutionR, deltafd, deltaA, resolutionAzi);
    end
end
%相邻方向向的凝聚
combineGroup = aziGroup2{1};
orginCombineGroup = orginGroup2{1};
if length(angleAxis) > 1
    for i = 2:length(angleAxis)
        len = size(aziGroup2{i},1);
        for k = 1:len
            flag = 0;
            for j = 1:size(combineGroup,1)
                if (abs(aziGroup2{i}(k,1)-combineGroup(j,1))<abs(0.5*(aziGroup2{i}(k,5)+combineGroup(j,5)))) && (abs(aziGroup2{i}(k,2) - combineGroup(j,2) < abs(0.5*(aziGroup2{i}(k,6)+combineGroup(j,6))+2*resolutionAzi))) && abs(aziGroup2{i}(k,3) - combineGroup(j,3)) <= deltafd && abs(aziGroup2{i}(k,4) - combineGroup(j,4)) <= deltaA
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
                orginCombineGroup = [orginCombineGroup orginGroup2{i}{k}];
            end
        end
    end
end
for i = 1:size(combineGroup, 1)
    if(combineGroup(i, 5) == 0)
        combineGroup(i, 5) = resolutionR;
    end
    if(combineGroup(i, 6) == 0)
        combineGroup(i, 6) = resolutionAzi;
    end    
end
end