id = uint32(8);
disp(idToOneHot(id));

function oneHotVector = idToOneHot(val)
    oneHotVector = zeros(3, 16, 'uint8');    
    for i = 0:2
        remainder = uint8(mod(val, 16));
        oneHotVector(3 - i, remainder + 1) = 1;
        val = floor(double(val) / 16);
    end
end


