% |      UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE      |
% |     Disciplina: Processamento Digital de Imagens      |
% |         Laborat�rio dos cap�tulos 1, 2, 3 e 4         |
% |            Docente: Heliana Bezerra Soares            |
% ---------------------------------------------------------
% Alunos: Eul�lia Costa Ribeiro e Gabriel Vin�cius Sousa da Silva

%%
%carregando os dados
I = imread('IDRiD_14.jpg')
%%
% A)e B) ser� que  � so isso mesmo?
IG = rgb2gray(I);
figure;
subplot(1,2,1);imshow(I);title('Imagem Original');
subplot(1,2,2);imshow(IG);title('Imagem em escala de cinza');
%%
%C)
I128 = IG/2;
I64 = IG/4;
I32 = IG/8;
I16 = IG/16;
I8 = IG/32;
I4 = IG/64;
I2 = imbinarize(IG);
figure;
subplot(2,4,1);imshow(IG);title('Imagem 256');
subplot(2,4,2);imshow(I128);title('Imagem 128');
subplot(2,4,3);imshow(I64);title('Imagem 64');
subplot(2,4,4);imshow(I32);title('Imagem 32');
subplot(2,4,5);imshow(I16);title('Imagem 16');
subplot(2,4,6);imshow(I8);title('Imagem 8');
subplot(2,4,7);imshow(I4);title('Imagem 4');
subplot(2,4,8);imshow(I2);title('Imagem 2');

%%
%D)
Irsz256 = imresize(IG, [256 256]); 
Irsz128 = imresize(IG, [128 128]); 
Irsz64 = imresize(IG, [64 64]); 
Irsz32 = imresize(IG, [32 32]); 
Irsz16 = imresize(IG, [16 16]); 

figure;
subplot(2,3,1);imshow(Irsz256);title('Imagem 256x256');
subplot(2,3,2);imshow(Irsz128);title('Imagem 128x128');
subplot(2,3,3);imshow(Irsz64);title('Imagem 64x64');
subplot(2,3,4);imshow(Irsz32);title('Imagem 32x32');
subplot(2,3,6);imshow(Irsz16);title('Imagem 16x16');
%%
%E)
e1 = imnoise(IG,'gaussian')
e2 = imnoise(IG,'poisson')
%%
figure;
subplot(1,2,1);imshow(e1);title('ru�do gaussiano');
subplot(1,2,2);imshow(e2);title('ru�do de Poisson');
%%
%F)
kernelsSize = [5 10 20 50];
kernels = {};
f1 = {}; %c�lula de filtros aplicados em e1
f2 = {}; %c�lula de filtros aplicados em e2
%criando as m�scaras
%%
for i = 1:length(kernelsSize)
    kernels{i} = ones(kernelsSize(i))/kernelsSize(i)^2;
end  
%%
%Filtrando as imagens ruidosas
for i = 1:length(kernels)
    f1{i} = uint8(conv2(double(e1),double(kernels{i})));
    f2{i} = uint8(conv2(double(e2),double(kernels{i})));
    disp(i);
end  
%%
%plotando os resultados

figure;
for i = 1:8
    if i <= 4
       subplot(2,4,i);imshow(f1{i});title(sprintf('Gaussiano filtrado %x%',kernelsSize(i)));
    else
        disp(i);
       subplot(2,4,i);imshow(f2{i-4});title(sprintf('Poisson filtrado %x%',kernelsSize(i-4)));
    end    
  
end
%%