function res = HighPassFilter(image,r)
            %Criando a mascara
            [yd, xd] = size(image);
            
            %criando simetricamente a mascara para x e y
            x = -xd./2:xd./2-1;  
            y = -yd./2:yd./2-1; 
            
            %criando um grid 2d com os valores de x e y
            [X, Y] = meshgrid(x, y); %mascara simetrica
            
            %calculando o raio
            z = sqrt(X.^2 + Y.^2)
            
            %pegando os valores de frequência abaixo do raio especificado
            c = z>r;
            
            res = c;       
  end    

