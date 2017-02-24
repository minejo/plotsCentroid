function [groupPoints,group] = listCombine(azigroup, resolutionR, deltafd, deltaA, resolutionAzi)
azigroup = sortrows(azigroup, 1);
group = {[azigroup(1,:)]};
if size(azigroup,1) > 1
    for i = 2:size(azigroup,1)
        if azigroup(i,1) - azigroup(i-1,1) <= resolutionR && abs(azigroup(i,3) - azigroup(i-1,3)) < deltafd && abs(azigroup(i,4) - azigroup(i-1,4)) < deltaA
            group{end} = [group{end}; azigroup(i,:)];
        else
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