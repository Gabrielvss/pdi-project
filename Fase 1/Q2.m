% |      UNIVERSIDADE FEDERAL DO RIO GRANDE DO NORTE      |
% |     Disciplina: Processamento Digital de Imagens      |
% |         Laboratório dos capítulos 1, 2, 3 e 4         |
% |            Docente: Heliana Bezerra Soares            |
% ---------------------------------------------------------
% Alunos: Eulália Costa Ribeiro e Gabriel Vinícius Sousa da Silva

%%
%carregando os dados
%A)
I = imread('IDRiD_14.jpg')
I = rgb2gray(I);
figure;imshow(I);title('Imagem');
%%
%B)
%Filtro de media e mediana 
kernelMedia = ones(3)/9;
highPass = HighPassFilter(I,20);
b =  filterFourier(I,highPass);
b1 = convolve(kernelMedia, ifftShow(b));
b2 = medfilt2(ifftShow(b),[3 3]);
%%
%Plotando as respostas
figure;
subplot(1,3,1);imshow(ifftShow(b));title('Filtro passa alta');
subplot(1,3,2);imshow(ifftShow(b1));title('Passa alta + media');
subplot(1,3,3);imshow(ifftShow(b2));title('Passa alta + mediana');
%%
%C)
%limiarização
%calculando o limiar globla
levelB1 = graythresh(b1);
levelB2 = graythresh(b2);
%aplicando a limiarização
Lb1 = imbinarize(b1,levelB1);
Lb2 = imbinarize(b2,levelB2);
figure;
subplot(1,2,1);imshow(Lb1);title('Limiarização do Filtro de media');
subplot(1,2,2);imshow(Lb2);title('Limiarização do Filtro de mediana');
%%
%D)
d = imnoise(I,'salt & pepper')
figure;imshow(d);title('Imagem com ruído sal e pimenta');
%%
%E)
%Criando as mascaras
kernelsSize = [3 5 15];
kernels = {};

for i = 1:length(kernelsSize)
    kernels{i} = ones(kernelsSize(i))/kernelsSize(i)^2;
end  
%%
%Filtrando as imagem ruidosa
E= {};%célula de imagens filtradas
for i = 1:length(kernels)
    E{i} = convolve(kernels{i}, d);
    disp(i);
end  
%%
%plotando os resultados
figure;
for i = 1:length(kernels)
    subplot(1,3,i);imshow(E{i});title(sprintf('Filtro de media %d',kernelsSize(i)));
end
%%
%F)
%máscara laplaciana que considera as diagonais
mask = [1 1 1; 1 -8 1; 1 1 1];
F ={}; %célula de imagens filtradas
%Aplicando laplace nas imagens da letra D
for i = 1:length(E)
    F{i} = convolve(mask, E{i});
    disp(i);
end 
%%
%plotando os resultados
laplaceImage = convolve(mask,I);
figure;
subplot(2,2,1);imshow(laplaceImage);title('Laplaciano na imagem original');
for i = 1:length(F)
    subplot(2,2,i+1);imshow(F{i});title(sprintf('Laplaciano no filtro de media %d',kernelsSize(i)));
end
%%
%G)
[fImage fEspctro] = homomorphicFilter(I, 10);
%% plotando resultados
figure;
subplot(1,2,1);imshow(I);title('Imagem Original');
subplot(1,2,2);imshow(ifftShow(fImage));title('Filtragem Homórfica');
%%
%H)
w1 = [1 2 1; 2 4 2;1 2 1]/16;
w2 = [-1 -1 -1;-1 4 -1;-1 -1 -1]/16;

h1 = convolve(w1,d);
h2 = convolve(w2,d);
h3 = convolve(w1,fImage);
h4 = convolve(w2,fImage);
%TODO pq h2 está saindo totalmente preto

%%
%Plotando os resultados
figure;
subplot(2,2,1);imshow(h1);title('Imagem d com w1');
subplot(2,2,2);imshow(h2);title('Imagem d com w2');
subplot(2,2,3);imshow(ifftShow(h3));title('Imagem g com w1');
subplot(2,2,4);imshow(h4);title('Imagem g com w2');
%%