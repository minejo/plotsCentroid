function combineGroup = dbscanCentroid(data, AM_init)
disDoor = 1;
aziDoor = 1;
vDoor = 2;
[class, type] = dbscan(data, 4, sqrt(disDoor^2 + aziDoor^2 + vDoor^2));
clusternum = max(class); %聚合后簇的数量
if clusternum ~= -1
    objectCell = cell(1, clusternum);%存放各个簇的cell单元
    %objectSize = zeros(1, clusternum); %保存各个簇的大概尺寸，用户后续的点迹过滤
    %把目标根据dbscan分类后的class变量分别分到对应的cell簇单元中
    for j = 1:size(data,1)
        if class(j) ~= -1
            if isempty(objectCell{class(j)})
                objectCell{class(j)} = [data(j,:) AM_init(j)];
            else
                objectCell{class(j)} = [objectCell{class(j)}; data(j,:) AM_init(j)];
            end
        end
    end
else
    objectCell = [];
    clusternum = 0;
end

combineGroup = [];
for j = 1:clusternum
    cludis = objectCell{j}(:,1);%取簇中的距离维
    cluazi = objectCell{j}(:,2);%取簇中的方位向
    cluv = objectCell{j}(:,3);%去簇中的速度维
    cluam = objectCell{j}(:,4);
    clusterDis = max(cludis) - min(cludis);
    clusterAzi = max(cluazi) - min(cluazi);
    [centerDis, centerAzi, centerV] = centerOfMass(cludis, cluazi, cluv, cluam);
    combineGroup = [combineGroup; centerDis centerAzi centerV mean(cluam) clusterDis clusterAzi];
end
end