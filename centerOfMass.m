function [aveDis, aveAzi, aveV] = centerOfMass(R, AZI, V, Am)
aveAzi = sum(Am.*AZI)/sum(Am);
aveDis = sum(Am.*R)/sum(Am);
aveV = sum(Am.*V)/sum(Am);
end