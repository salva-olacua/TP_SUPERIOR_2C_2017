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


function menuDeOpciones
  %disp("Ingresar datos para la aproximacion")
 while(true)
  opcion = menu ("menu de opciones", "Cargar Datos", "Comparar Aproximaciones","Finalizar");
    switch (opcion)
      case 1
        cargarDatos();
        menuDeAproximaciones();
      case 2
        compararAproximaciones();
      case 3
        break;
    endswitch
 endwhile
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


menuDeOpciones();