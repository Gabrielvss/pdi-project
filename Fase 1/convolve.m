function [filterImage] = convolve(mask,image)
    filterImage = uint8(conv2(double(image),double(mask)));
end

