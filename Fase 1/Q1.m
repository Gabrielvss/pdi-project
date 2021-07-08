% |      UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE      |
% |     Disciplina: Processamento Digital de Imagens      |
% |         Laboratório dos capítulos 1, 2, 3 e 4         |
% |            Docente: Heliana Bezerra Soares            |
% ---------------------------------------------------------
% Alunos: Eulália Costa Ribeiro e Gabriel Vinícius Sousa da Silva

%%
%carregando os dados
I = imread('IDRiD_14.jpg')
%%
% A)e B) será que  é so isso mesmo?
IG = rgb2gray(I);
figure;
subplot(1,2,1);imshow(IG);title('Imagem Original');
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
subplot(1,2,1);imshow(e1);title('ruído gaussiano');
subplot(1,2,2);imshow(e2);title('ruído de Poisson');
%%
%F)
kernelsSize = [5 10 20 50];
kernels = {};
f1 = {}; %célula de filtros aplicados em e1
f2 = {}; %célula de filtros aplicados em e2
%criando as máscaras
%%
for i = 1:length(kernelsSize)
    kernels{i} = ones(kernelsSize(i))/kernelsSize(i)^2;
    disp(sprintf('Contruindo mascara %x%',kernelsSize(i)));
end  
%%
%Filtrando as imagens ruidosas
for i = 1:length(kernels)
    f1{i} = uint8(imfilter(double(e1),double(kernels{i})));
    f2{i} = uint8(imfilter(double(e2),double(kernels{i})));
  
    disp(sprintf('filtrando imagem com máscara %d',kernelsSize(i)));
end  
%%
%plotando os resultados

figure;
for i = 1:8
    if i <= 4
       subplot(2,4,i);imshow(f1{i});title(sprintf('Gaussiano filtrado %d',kernelsSize(i)));
    else
        disp(i);
       subplot(2,4,i);imshow(f2{i-4});title(sprintf('Poisson filtrado %d',kernelsSize(i-4)));
    end    
  
end
%%
%G)
%escolhendo a janela de tamamho 3 para e1 e e2
g1 = IG - e1 - f1{3};
g2 = IG - e2 - f2{3};
%%
%H) 
%gerando uma imagem com o mesmo tamanho que a orginal, com valor constante
%igual a 5, seria a mesma coisa que somar esse valor diretamente a imagem
c = uint8(ones(size(IG))*5); 
h1 = c + f1{2};
h2 = c + f1{4};
figure;
subplot(1,3,1);imshow(IG);title('imagem original');
subplot(1,3,2);imshow(h1);title('c + f(2)');
subplot(1,3,3);imshow(h2);title('c + f(4)');
%%
%I) imagem negativa
IN = 255 - IG;
g1n = 255 - g1;
g2n = 255 - g2;
figure;
subplot(1,3,1);imshow(IN);title('imagem original negativa');
subplot(1,3,2);imshow(g1n);title('G1 negativo');
subplot(1,3,3);imshow(g2n);title('G2 negativo');
%%
%J)
figure;
subplot(1,2,1);imshow(IG|g1);title('I U G1');
subplot(1,2,2);imshow(IG|g2);title('I U G2');
%%
%K)
figure;
subplot(1,3,1);histogram(IG);title('Histograma da imagem original');
subplot(1,3,2);histogram(e1);title('Histograma do ruido Gaussiano');
subplot(1,3,3);histogram(e2);title('Histograma do ruido de Poisson');
%%
figure;
for i=1:4
subplot(2,2,i);histogram(f1{i});title(sprintf('Gaussiano filtrado com média %d',kernelsSize(i)));
end
%%
figure;
for i=1:4
subplot(2,2,i);histogram(f2{i});title(sprintf('Poisson filtrado com média %d',kernelsSize(i)));
end
%%
figure;
subplot(1,2,1);histogram(g1);title('Histograma de (I) - (e1) – (f1)');
subplot(1,2,2);histogram(g2);title('Histograma (I) - (e2) – (f3)');
%%
%L)
figure;
subplot(2,4,1);histogram(adapthisteq(IG));title('L = 256');
subplot(2,4,2);histogram(adapthisteq(I128));title('L = 128');
subplot(2,4,3);histogram(adapthisteq(I64));title('L = 64');
subplot(2,4,4);histogram(adapthisteq(I32));title('L = 32');
subplot(2,4,5);histogram(adapthisteq(I16));title('L = 16');
subplot(2,4,6);histogram(adapthisteq(I8));title('L = 8');
subplot(2,4,7);histogram(adapthisteq(I4));title('L = 4');
subplot(2,4,8);histogram(adapthisteq(double(I2)));title('L = 2');
%%