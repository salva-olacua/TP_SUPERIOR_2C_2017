global datosXs;
global datosYs;
global opcion;
global opcion2;


pkg load control;
pkg load signal;

clear;


function cargarDatos
  %cargar los datos!!!
  display('formato de carga x=[ X0,X1,X2,...,Xn], y=[f(X0),f(X1),f(X2),...,f(Xn)]');
  x=input('x= ');
  y=input('y= ');
  display('datos cargados'); 
endfunction


function compararAproximaciones
  %averiguar el tema de la comparacion de aproximaciones en octave!!!
  display('comparacion de aproximaciones');
endfunction

function menuDeAproximaciones
  
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
     opcion1()
    case 2
     opcion2()
    case 3
     opcion3()
    case 4
     opcion4()
    case 5
     opcion5()
    case 6
     break;
  endswitch
endwhile

endfunction


eleccion_1=listdlg("Name","AMIC","ListSize", [500 500],"ListString",{"Cargar Datos","Comparar Aproximaciones"},"SelectionMode","Single","CancelString","Finalizar");

switch(eleccion_1)
  case 1 %cargarDatos
    global opcion;
    global datosXs;
    global datosYs;
    msgbox("Ingrese la misma cantidad de valores de Xs que de Ys, separados por espacios");
    coefnum=inputdlg("Ingresar Xs","AMIC");
    coefden=inputdlg("Ingresar Ys","AMIC");
    opcion=1;
   case 2 %compararAproximaciones
     
    otherwise
    quit;
endswitch

 if(opcion==1)  
  msgbox("Elegir expresion aproximante");
  
  eleccion_2=listdlg("Name","AMIC","ListSize", [500 500],"ListString",{"Recta de minimos cuadrados: y = ax+b","Parabola de minimos cuadrados: y = ax^2+bx+c","Aproximacion Exponencial: y = be^ax","Aproximacion Potencial: y = bx^a","Aproximacion Hiperbola: y = a/x+b"},"SelectionMode","Single");
  switch(eleccion_2)
  case 1 %Recta de mínimos cuadrados: y = ax+b
    global opcion2;
    opcion2 = 1;
    
  case 2 %Parábola de mínimos cuadrados: y = ax^2+bx+c
    global opcion2;
    opcion2 = 2;    
  case 3 %Aproximación Exponencial: y = be^ax
    global opcion2;
    opcion2 = 3;    
  case 4 %Aproximación Potencial: y = bx^a
    global opcion2;
    opcion2 = 4;  
  case 5 %Aproximación Hipérbola: y = a/x+b
    global opcion2;
    opcion2 = 5;    
    otherwise
    quit;
endswitch

 elseif(opcion==2) %compararAproximaciones
 
 endif
 
  eleccion_3=listdlg("Name","AMIC","ListSize", [500 500],"ListString",{"Mostrar la funcion aproximante","Obtener el detalle del calculo", "Graficar la nube de puntos junto al polinomio encontrado"},"SelectionMode","Single","CancelString","Finalizar");
 switch(eleccion_3)
  
  case 1 %Mostrar la función aproximante

  case 2 %Obtener el detalle del cálculo
    
  case 3 %Graficar la nube de puntos junto al polinomio encontrado
   
    otherwise
    quit;
endswitch
