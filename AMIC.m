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



function mostrarFuncionAproximante(a,b,funcionAproximante)
  msgbox({funcionAproximante strcat("a= ",num2str(a)) strcat("b= ",num2str(b)) });
endfunction


function menuDeOpciones
 while(true)
  opcion = menu ("menu de opciones", "Cargar Datos", "Comparar Aproximaciones","Finalizar");
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



function menuDeOpcionesPorAproximacion(x,y,a,b,grafica)
  while(true)
  opcion = menu ("menu de interaccion por aproximacion elegida",
                 "Mostrar la funcion aproximante",
                 "Obtener el detalle del calculo",
                 "Visualizar grafica",
                 "Volver al menu de aproximacion");
    switch (opcion)
      case 1
        mostrarFuncionAproximante(a,b,grafica);
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
  opcion = menu ("Aproximar mediante: ",
    "1. Recta de mínimos cuadrados: y = ax+b.",
    "2. Parábola de mínimos cuadrados: y = ax^2+bx+c.",
    "3. Aproximación Exponencial: y = be^ax.",
    "4. Aproximación Potencial: y = bx^a .",
    "5. Aproximación Hipérbola: y = a/x+b .",
    "6. Volver al menu de opciones .");
  switch (opcion)
    case 1
     [a,b]=aproximacionPorRecta(x,y);
     recta="y=mx+b";
     menuDeOpcionesPorAproximacion(x,y,a,b,recta);
    case 2
     opcion2();
    case 3
     opcion3();
    case 4
     opcion4();
    case 5
     opcion5();
    case 6
     break;
  endswitch
endwhile

endfunction


menuDeOpciones();