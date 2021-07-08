 function res = fftShow(f)
        f1 = log(1+abs(f));
        fm = max(f1(:));
        res = f1/fm;
end
