Pilota pilota1; // declaración de la variable que contindrá l'objecte pilota

// funció de configuració
void setup() {
  size(600, 400); // mida pantalla
  frameRate (60); // 60 frames per segon

  // assignació, construcció de l'objecte pilota
  pilota1 = new Pilota(
    10,                   //c_radius, radi pilota
    1,                    //c_signe, sentit animació (1 positiu, -1 negatiu)
    color(255,255,255),   //c_c, color de la pilota
    width/2,              //c_pos_x, posició inicial x
    height/2,             //c_pos_y, posició inicial y
    2                     //c_vel, pixeles que es mou cada frame
    );
}

// funció que s'executa a cada frame
void draw() {
  
  background(0, 0, 0);      // dibuixem fondo

  pilota1.draw_pilota();    // crida al métode que dibuixa la pilota

  pilota1.check_colision(); // comprova si hi ha xocat amb el limit
                            // si ha xocat canvia direcció

  pilota1.update_pilota();  // calcula la nova posició pilota

  // escenario
  fill(100, 100, 100);
  rect(0, height/2+10, width, height);
};

// classe del objecte bomba
class Pilota{

  // atributs objecte
  int radius;   // radi pilota
  int signe;    // sentit animació
  color c;      // color del móbil
  float pos_x;  // Posicisió inicial x del móbil
  float pos_y;  // Posicisió inicial y del móbil
  float vel;    // pixels per frame


  //constructor de l'objecte, amb els seus parámetres definitoris
  Pilota(
    int c_radius,
    int c_signe,
    color c_c,
    float c_pos_x,
    float c_pos_y,
    float c_vel
    ){
    // Assignació valors (atributs constructor) a atributs objecte
    radius = c_radius;  // radi pilota
    signe = c_signe;    // sentit animació
    c = c_c;            // color del móbil
    pos_x = c_pos_x;    // Posicisió inicial x del móbil
    pos_y = c_pos_y;    // Posicisió inicial y del móbil
    vel = c_vel;        // pixels per frame
  }

  // métode calcul nova posició
  void update_pilota(){
    pos_x += (signe*vel);  // a la posició "x" se li resta o suma el desplaçament vel
                           // el valor de signe (-1 o 1) fa que es mogui en una direcció
                           // o en una altra (dreta "1", esquerra "-1")

    pos_y = pos_y;         // la posició "y" sempre es la mateixa
                           // només es mou en horizontal
                           // es pot obviar aquesta línea
  }   

  // metode que dibuixa la pilota
  void draw_pilota(){
    fill (c);                               // color pilota
    ellipseMode(RADIUS);                    // tipus de cercle
    ellipse (pos_x, pos_y, radius, radius); // dibuixem cercle
  }
 
   // métode que comprova col·lisió pilota amb límit escenari
  void check_colision(){
    // comparació posició pilota amb limit escenari
    if (pos_x < radius || pos_x > width-radius) {
      signe *= -1;  // si es compleix conidió cambiem el signe animació
    } 
  }

}


