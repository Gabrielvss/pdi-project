function [filterImage,espectro] = homomorphicFilter(image,d)

disp('Iniando os calculos');
%as dimensões do filtro seram as mesmas da imagem
[r c] = size(image);
image = double(image);

disp('Calculando o filtro gaussiano');
%aproxiamando o filtro por um passa alta gaussiano
for i=1:r
    for j=1:c
        A(i,j)=(((i-r/2).^2+(j-c/2).^2)).^(.5);
        B(i,j)=A(i,j)*A(i,j);
        H(i,j)=(1-exp(-((B(i,j)).^2/d.^2)));
    end
end

disp('calculandi o filtro homomórfica');
%definido os limites da função
rL=.25;
rH=2;
H=((rH-rL).*H)+rL;

disp('aplicando o log na frequencia');
%calculando o log da imagem
im_l=log2(1+image);

%DFT do log da imagem
im_f=fft2(im_l);

%aplicando o filtro na transformada
im_nf=H.*im_f;

%IFFT para construção da imagem
im_n=abs(ifft2(im_nf));

disp('aplicando a exp no espacaço');
%invertendo o log
im_e=exp(im_n);

filterImage = im_e;
espectro = im_nf; 

disp('fim')

end

