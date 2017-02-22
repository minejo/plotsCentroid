function observeValue = getObserveValue(value, resolution)
%根据分辨率，获取实际值在当前分辨率情形下获取到的观测值
observeValue = floor(value/resolution)*resolution + 0.5*resolution;
end