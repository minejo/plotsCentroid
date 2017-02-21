function [aveDis, aveAzi] = centerOfMass(R, AZI, Am)
aveAzi = sum(Am.*AZI)/sum(Am);
aveDis = sum(Am.*R)/sum(Am);
end