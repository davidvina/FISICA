// variables
int ball_radius;
float ball_y;
float ball_y0;
float ball_x;
float ball_x0;
float time;
float v_0;
float angle;
float a ;

// configuración entorno
void setup() {
  size(600, 600);
  frameRate (70);
  ball_radius = 20;
  ball_y = 250.0;  
  ball_y0 = 250.0;
  ball_x = 250.0;
  ball_x0 = 150.0;
  time = 0.0;
  v_0= 50 ;
  angle = PI/4 ;
  a = 10 ;
}

// función que dibuja la aplicación
void draw() {
  background(255, 255, 255);
  fill (0, 0, 0);
  ellipse (ball_x, ball_y, ball_radius, ball_radius);
  ball_x = ball_x0 + v_0*cos(angle)*time ;
  ball_y = ball_y0 - v_0*sin(angle)*time +a/2*sq(time) ;
  time = time + 0.07;
}
