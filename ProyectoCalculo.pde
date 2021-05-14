 import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import java.util.Scanner;


 PeasyCam cam;
 
float y;
int r, g, b, i, j, n, np=0, cc=20;
int [][][] colores1=new int[101][101][3];
float n1,n2,n3,n4,n5,n6,n7,n8,n9,n10;
float entrada;

  float b1=4,b2=12,b3=13,b4=18,b5=22;
 
  float a1=0,a2=b1,a3=b2,a4=b3,a5=b4;
   //float a1=0,a2=8,a3=24,a4=26,a5=36;
   //float b1=8,b2=24,b3=26,b4=36,b5=44;
  // float a1=0,a2=80,a3=240,a4=260,a5=360;
  // float b1=80,b2=240,b3=260,b4=360,b5=440;
  double integral=0,integral2=0,integral3=0,integral4=0,integral5=0;
  double funcion=0,funcion2=0,total=0;
  float x=0,x2=0;
  double pi=3.141591654;
    PImage fondo;


void setup() {
  cam = new PeasyCam(this,100);
cam.setMinimumDistance(50);
cam.setMaximumDistance(2000000);
 smooth(2);
 size(800, 800, P3D);
 ////////////////////////////Integrales////////////////
 //primera de 0 a 4
 //Segunda de 4 a 12
 //Tercera de 12 a 13
 //Cuarta de 13 a 18
 //Quinta de 18 a 22
 volumen();
 
fondo = loadImage("estrellasgrande.gif");
//image(fondo, 0, 0);

}

void draw() {
 
 background(fondo);
 
 lights();//iluminación /sombra
 translate(0, (b1-a1)*-30, 0);//punto medio de la figura
 noStroke(); //sin lineas
 fill(#FF001E); //Color rojo
////////////(ancho1,ancho2,largo,lados)
 dibujarCilindro(0, (b2-a2)*2.25, (b1-a1)*10, 100); //Cono
translate(0, (b1-a1)*10, 0);
fill(#F200FF); //Color morado 
dibujarCilindro((b2-a2)*2.25, (b2-a2)*2.25, (b2-a2)*10, 100); //Cilindro1
translate(0, (b2-a2)*10, 0);
fill(#00FFE8); //Color azul claro
dibujarCilindro((b2-a2)*2.25, (b4-a4)*4, (b3-a3)*10, 100); //cilindro2
translate(0, (b3-a3)*10, 0);
fill(#0700FF); //Color azul fuerte
 dibujarCilindro((b4-a4)*4, (b4-a4)*4,(b4-a4)*10, 100); //cilindro3
 translate(0, (b4-a4)*10, 0);
 fill(#00FF01); //Color verde
 dibujarCilindro((b4-a4)*4,(b5-a5)*8.75, (b5-a5)*10, 100); //Cilindro4
   
 fuego();

}


void dibujarCilindro(float topRadius, float bottomRadius, float tall, int sides) //creacíon figura 
{
 float angle = 0;
 float angleIncrement = TWO_PI / sides;
 beginShape(QUAD_STRIP);
 for (int i = 0; i < sides + 1; ++i) {
 vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
 vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
 angle += angleIncrement;
 }
 endShape();
 //Si no es un cono, dibujar el circulo arriba
 if (topRadius != 0) {
 angle = 0;
 beginShape(TRIANGLE_FAN);
 //Punto Central
 vertex(0,tall,0);
 for (int i = 0; i < sides + 1; i++) {
 vertex(topRadius * cos(angle), 0, topRadius *
sin(angle));
 angle += angleIncrement;
 }
 endShape();
}
 //Si no es un cono, dibujar el circulo abajo
 if (bottomRadius != 0) {
 angle = 0;

 beginShape(TRIANGLE_FAN);
 // Punto central 
 vertex(0, tall, 0);
 for (int i = 0; i < sides+1; i++) {
 vertex(bottomRadius * cos(angle), tall, bottomRadius *
sin(angle));
 angle += angleIncrement;
 }
 endShape();
 }
} 
 
void fuego() {
  delay(5);
  for (i=12; i>=1; i--) {
    for (j=15; j>=1; j--) {

      if (j==15 ) {
        if ((int)random(0, 10)%3==0) { 
          //rojo
          r=255;
          g=0;
          b=0;
        } else if ((int)random(0, 10)%2==0) {
          //amarillo
          r=g=255;
          b=0;
        } else if ((int)random(0, 10)%2==0) {
          r=g=b=255;
        } else {
          r=g=255;
          b=0;
        }
        colores1[i][j][0]=r;
        colores1[i][j][1]=g;
        colores1[i][j][2]=b;
      } else if (i>1 && j>1 &&i<12 &&j<15) {
        if ((int)random(0, 10)%5==0) {
          n=0;
        } else {
         
          n=(int)random(0, 5);
        }

        r=(colores1[i][j][0]+colores1[i-1][j+1][0]+colores1[i][j+1][0]+colores1[i+1][j+1][0])/4-n;
        g=(colores1[i][j][1]+colores1[i-1][j+1][1]+colores1[i][j+1][1]+colores1[i+1][j+1][1])/4-n;
        b=(colores1[i][j][2]+colores1[i-1][j+1][2]+colores1[i][j+1][2]+colores1[i+1][j+1][2])/4-n;
        if (r<0)
          r=0;
        if (g<0)
          g=0;
        if (b<0)
          b=0;
        ////////////
        //////////
        colores1[i][j][0]=r;
        colores1[i][j][1]=g;
        colores1[i][j][2]=b;
        cuadro c=new cuadro(i-7, j-22, r, g, b);
        if (j<96)
          c.pinta();       
      }
    }
  }
}
class cuadro {
  int x, y, r, g, b;

  cuadro(int xx, int yy, int rr, int gg, int bb) {
    x=xx;
    y=yy;
    r=rr;
    g=gg;
    b=bb;
  }
  void pinta() {
    fill(r, g, b);
    rect(x*(b4-a4), -y*(b4-a4), (b4-a4), (b4-a4));
  }
}
void volumen(){
///integral 1      
 x = pow(b1,2);
 x2 = pow(a1,2);
 funcion = 0.25*x;
 funcion2 = 0.25*x2;
 integral = (funcion-funcion2);
// cout<<"\nResultado 1= "<<integral;
  ///integral 2
 funcion = 2*b2;
 funcion2 = 2*a2;
 integral2 = funcion-funcion2;
// cout<<"\nResultado 2= "<<integral2;
  ///integral 3
 x = pow(b3,3);
 x2 = pow(b3,2);
 funcion = (0.1083*x)-(3.092*x2)+(29.44*b3);
 x = pow(a3,3);
 x2 = pow(a3,2);
 funcion2 = (0.1083*x)-(3.092*x2)+(29.44*a3);
 integral3 = funcion-funcion2;
 //cout<<"\nResultado 3= "<<integral3;
  ///integral 4 
 funcion = 4*b4;
 funcion2 = 4*a4;
 integral4 = (funcion-funcion2);
 //cout<<"\nResultado 4= "<<integral4;
  ///integral 5 
 x = pow(b5,3);
 x2 = pow(b5,2);
 funcion = (0.1083*x)-(4.7082*x2)+(68.2262*b5);
 x = pow(a5,3);
 x2 = pow(a5,2);
 funcion2 = (0.1083*x)-(4.7082*x2)+(68.2262*a5);
 integral5 = funcion-funcion2;
 //cout<<"\nResultado 5= "<<integral5;
 
 total=integral + integral2 + integral3 + integral4 + integral5;
 //cout<<"\nSuma de resultados = "<< total;
 total *=pi;
     println("El volumen total aproximado es de: ",total," m^3");
}



   
    
