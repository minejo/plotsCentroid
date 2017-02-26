function [groupPoints,group] = listCombine(azigroup, resolutionR, deltafd, deltaA, resolutionAzi)
azigroup = sortrows(azigroup, 1);
group = {[azigroup(1,:)]};
if size(azigroup,1) > 1
    for i = 2:size(azigroup,1)
        flag = 0;
        for j = 1:length(group)
            if azigroup(i,1) - group{j}(end,1) <= resolutionR && abs(azigroup(i,3) - group{j}(end,3)) <= deltafd && abs(azigroup(i,4) - group{j}(end, 4)) <= deltaA
                group{j} = [group{j}; azigroup(i,:)];
                flag = 1;
                break;
            end
        end
        if flag == 0
            group = [group [azigroup(i,:)]];
        end
    end
end
groupPoints =[];
for i = 1:length(group)
    [centerDis, centerAzi, centerV] = centerOfMass(group{i}(:,1), group{i}(:,2), group{i}(:,3), group{i}(:,4));
    groupPoints = [groupPoints;centerDis centerAzi centerV mean(group{i}(:,4)) max(group{i}(:,1)) - min(group{i}(:,1)) max(group{i}(:,2)) - min(group{i}(:,2))];
end
end