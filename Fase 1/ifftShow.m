function res = ifftShow(f)
    f1 = abs(f);
    fm = max(f1(:));
    res = f1/fm;
end  

