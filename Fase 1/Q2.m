% |      UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE      |
% |     Disciplina: Processamento Digital de Imagens      |
% |         Laborat�rio dos cap�tulos 1, 2, 3 e 4         |
% |            Docente: Heliana Bezerra Soares            |
% ---------------------------------------------------------
% Alunos: Eul�lia Costa Ribeiro e Gabriel Vin�cius Sousa da Silva

%%
%carregando os dados
%A)
I = imread('IDRiD_14.jpg')
I = rgb2gray(I);
figure;imshow(I);title('Imagem');
%%
%B)
%Filtro de media e mediana
kelnelMedia = ones(5)/25;
b1 = convolve(kelnelMedia, I);
b2 = medfilt2(I,[5 5]);
figure;
subplot(1,2,1);imshow(b1);title('Filtro de media5x5');
subplot(1,2,2);imshow(b2);title('Filtro de mediana5x5');
%%
%limiariza��o
%calculando o limiar globla
levelB1 = graythresh(b1)
levelB2 = graythresh(b2)
%aplicando a limiariza��o
Lb1 = imbinarize(I,levelB1);
Lb2 = imbinarize(I,levelB2);
figure;
subplot(1,2,1);imshow(Lb1);title('Limiariza��o do Filtro de medis');
subplot(1,2,2);imshow(Lb2);title('Limiariza��o do Filtro de mediana');
%%
%C)
c = imnoise(I,'salt & pepper')
figure;imshow(c);title('Imagem co ruido sal e pimenta');
%%
%D)
%Criando as mascaras
kernelsSize = [3 5 15];
kernels = {};

for i = 1:length(kernelsSize)
    kernels{i} = ones(kernelsSize(i))/kernelsSize(i)^2;
end  
%%
%Filtrando as imagem ruidosa
D= {};%c�lula de imagens filtradas
for i = 1:length(kernels)
    D{i} = convolve(kernels{i}, c);
    disp(i);
end  
%%
%plotando os resultados
figure;
for i = 1:length(kernels)
    subplot(1,3,i);imshow(D{i});title(sprintf('Filtro de media %x%',kernelsSize(i)));
end
%%
%E)
%m�scara laplaciana que considera as diagonais
mask = [1 1 1; 1 -8 1; 1 1 1];
E ={}; %c�lula de imagens filtradas
%Aplicando laplace nas imagens da letra D
for i = 1:length(D)
    E{i} = convolve(mask, D{i});
    disp(i);
end 
%%
%plotando os resultados
figure;
for i = 1:length(E)
    subplot(1,3,i);imshow(E{i});title(sprintf('Filtro de Laplace no filtro %x%',kernelsSize(i)));
end
%%
%F)

%%