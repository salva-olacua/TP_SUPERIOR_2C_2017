pkg load control;
pkg load signal;

clear;


function [x,y,cant_decimales]=cargarDatos
  %errordlg("hgj"); utilizar para mensajes de error
  msgbox({'Formato de carga: ' 'x=[ X0,X1,X2,...,Xn]'  'y=[f(X0),f(X1),f(X2),...,f(Xn)]'});
  x_string=inputdlg('x= ','AMIC');
  x=str2num(x_string{1});
  y_string=inputdlg('y= ','AMIC');
  y=str2num(y_string{1});
  msgbox('Ingrese la cantidad de decimales que desea');
  dec_string=inputdlg('cantidad de decimales','AMIC');
  cant_decimales=str2num(dec_string{1});
  msgbox('datos cargados'); 
  %coeficientes=polyfit(x,y,1);
  %puntos_a_evaluar = linspace(1,4,20);
  %recta_de_aproximacion=polyval(coeficientes,puntos_a_evaluar);
  %plot(x, y,'r*');
  %hold on
  %plot(puntos_a_evaluar,recta_de_aproximacion,'m-.');
  %hold off
endfunction



function compararAproximaciones
  %averiguar el tema de la comparacion de aproximaciones en octave!!!
  display('comparacion de aproximaciones');
endfunction






function [a,b]=aproximacionPorRecta(x,y)
  sumatoria_x=sum(x);
  sumatoria_y=sum(y);
  
  tamanio_x=length(x);
  
  sumatoria_x_al_cuadrado=sum(x.^2);
  
  sumatoria_x_y = sum(x.*y);
  
  matriz_coeficientes= [sumatoria_x_al_cuadrado,sumatoria_x ; sumatoria_x,tamanio_x];
  matriz_aumentada= [sumatoria_x_y ; sumatoria_y];
  matriz_resultante= inv(matriz_coeficientes) * matriz_aumentada;
  a=matriz_resultante(1,1);
  b=matriz_resultante(2,1);
 
  
endfunction

%[1.2,1.8,3.1,4.9,5.7,7.1,8.6,9.8]
%[4.5,5.9,7.0,7.8,7.2,6.8,4.5,2.7]
function [a,b,c]=aproximacionPorCuadratica(x,y)
  
  sumatoria_x=sum(x);
  sumatoria_y=sum(y);
  
  cantidad_x=length(x);
  
  sumatoria_x_al_cuadrado=sum(x.^2);
  sumatoria_x_al_cubo=sum(x.^3);
  sumatoria_x_a_la_cuarta=sum(x.^4);
  sumatoria_x_y = sum(x.*y);
  sumatoria_x_al_cuadrado_y = sum((x.^2).*y);  
  
  matrix_coeficientes = [cantidad_x,sumatoria_x,sumatoria_x_al_cuadrado;
                         sumatoria_x,sumatoria_x_al_cuadrado,sumatoria_x_al_cubo;
                         sumatoria_x_al_cuadrado,sumatoria_x_al_cubo,sumatoria_x_a_la_cuarta];
  matrix_constantes = [sumatoria_y,sumatoria_x_y,sumatoria_x_al_cuadrado_y];
  matrix_resultante = matrix_constantes/matrix_coeficientes;
  
  a=matrix_resultante(1,3);
  b=matrix_resultante(1,2);
  c=matrix_resultante(1,1);
  
 endfunction
 
 
 %[1,1.25,1.5,1.75,2]
 %[5.1,5.79,6.53,7.45,8.46]
 function [a,b]=aproximacionPorExponencial(x,y)
   sumatoria_x=sum(x);
   sumatoria_lny=sum(log(y));
   cantidad_x = length(x);
   sumatoria_x_al_cuadrado=sum(x.^2);
   sumatoria_x_lny = sum(x.*log(y));
 
  matrix_coeficientes = [sumatoria_x_al_cuadrado,sumatoria_x;sumatoria_x,cantidad_x];
  matrix_constantes = [sumatoria_x_lny,sumatoria_lny];
 matrix_resultante= matrix_constantes / matrix_coeficientes;
  A=matrix_resultante(1,1);
  B=matrix_resultante(1,2);
  
  a=A;
  b=e^B;
 endfunction  

 %[1,1.2,2,2.5,2.9]
 %[2.6,3.8,5.2,7.1,8]
 
 function [a,b]=aproximacionPorPotencial(x,y)
    sumatoria_logx=sum(log(x));
    sumatoria_logy=sum(log(y));
    
    sumatoria_logx_logy=sum(log(x).*log(y));
    sumatoria_logx_al_cuadrado=sum(log(x).^2);
    cantidad_x = length(x);
    
    matrix_coeficientes=[sumatoria_logx_al_cuadrado,sumatoria_logx;sumatoria_logx,cantidad_x];
    matrix_constantes=[sumatoria_logx_logy,sumatoria_logy];
    
    matrix_resultante= matrix_constantes / matrix_coeficientes;
    
    A=matrix_resultante(1,1);
    B=matrix_resultante(1,2);
    
    a=A;
    b=e^B;
 endfunction
 
 % [1,2,3,4]
 % [4,5,8,15]
 function [a,b]=aproximacionPorHiperbola(x,y)
   sumatoria_x = sum(x);
   cantidad_x = length(x);
   sumatoria_Y = sum(1./y); 
   sumatoria_x_al_cuadrado = sum(x.^2);
   sumatoria_x_y = sum(x.*(1./y));
   
   
   matrix_coeficientes = [cantidad_x,sumatoria_x;sumatoria_x,sumatoria_x_al_cuadrado];
   matrix_constantes = [sumatoria_Y,sumatoria_x_y];
   
   matrix_resultante=matrix_constantes/matrix_coeficientes;
   A=matrix_resultante(1,2);
   B=matrix_resultante(1,1);
 
  a=1/A;
  b=B*A;
 
 endfunction
 
 function mostrarFuncionAproximante(a,b,c,funcionAproximante)
  msgbox({funcionAproximante strcat("a= ",num2str(a)) strcat("b= ",num2str(b)) strcat("c= ",num2str(c))});
endfunction


function menuDeOpciones
 while(true)
  
  opcion = listdlg ("Name","AMIC","ListSize", [500,500],"ListString",{"Cargar Datos", "Comparar Aproximaciones","Finalizar"},"SelectionMode","Single");
    switch (opcion)
      case 1
        [x,y,cant_decimales]=cargarDatos();
        menuDeAproximaciones(x,y,cant_decimales);
      case 2
        compararAproximaciones();
      case 3
        
        break;
    endswitch
 endwhile
endfunction



function visualizarGrafica(x,y,a,b)
  plot(x, y,'r*');
  puntos_a_evaluar = linspace(1,4,20);
  recta_de_aproximacion=polyval([a b],puntos_a_evaluar);
  hold on
  plot(puntos_a_evaluar,recta_de_aproximacion,'m-.');
  hold off
endfunction



function menuDeOpcionesPorAproximacion(x,y,a,b,c,grafica)
  while(true)
  
   opcion = listdlg("Name"      ,"Menu de interaccion por aproximacion elegida",
                    "ListSize"  ,[500,500],
                    "ListString",{"Mostrar la funcion aproximante",
                                  "Obtener el detalle del calculo",
                                  "Visualizar grafica",
                                  "Volver al menu de aproximacion"},
                    "SelectionMode","Single");
    switch (opcion)
      case 1
        mostrarFuncionAproximante(a,b,c,grafica);
      case 2
        detalleDelCalculo();
      case 3
        visualizarGrafica(x,y,a,b);
      case 4
        break;
    endswitch
 endwhile
endfunction



function menuDeAproximaciones(x,y,cant_decimales)  
while(true)
  opcion = listdlg ("Name","Aproximar mediante: ",
                    "ListSize",[500,500],
                    "ListString",{"1. Recta de minimos cuadrados: y = ax+b.",
                                  "2. Parabola de minimos cuadrados: y = ax^2+bx+c.",
                                  "3. Aproximacion Exponencial: y = be^ax.",
                                  "4. Aproximacion Potencial: y = bx^a .",
                                  "5. Aproximacion Hiperbola: y = a/x+b .",
                                  "6. Volver al menu de opciones ."},
                    "SelectionMode","Single");
  switch (opcion)
    case 1
     [a,b]=aproximacionPorRecta(x,y);
     recta="y=mx+b";
     c=0;
     menuDeOpcionesPorAproximacion(x,y,a,b,c,recta);
    case 2
      [a,b,c]=aproximacionPorCuadratica(x,y);
      parabola="y=ax^2+bx+c";
      menuDeOpcionesPorAproximacion(x,y,a,b,c,parabola);
    case 3
      [a,b]=aproximacionPorExponencial(x,y);
      exponencial = "y = be^ax";
      c=0;
      menuDeOpcionesPorAproximacion(x,y,a,b,c,exponencial);
    case 4
      [a,b]=aproximacionPorPotencial(x,y);
      potencial = "y = bx^a";
      c=0;
      menuDeOpcionesPorAproximacion(x,y,a,b,c,potencial);
    case 5
      [a,b]=aproximacionPorHiperbola(x,y);
      hiperbola = "y = a/x+b";
      c=0;
      menuDeOpcionesPorAproximacion(x,y,a,b,c,hiperbola);
    case 6
      menuDeOpciones();
     break;
  endswitch
endwhile

endfunction


menuDeOpciones();