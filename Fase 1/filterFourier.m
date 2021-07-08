  function res = filterFourier(image,mask)
          fft = fftshift(fft2(image));
          ifft = ifft2(fft.*mask);
          res = ifft;  
  end
