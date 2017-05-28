
// declaramos arrayList
ArrayList<Bomba> bombas = new ArrayList<Bomba>();


void setup() {
  size(600, 400); 
  frameRate (70);


  // afegim quaranta bombes al arrayList
  for (int i = 0; i < 40; ++i) {

    bombas.add(new Bomba(
                 int(random(15, 30)), //mida lletra
                 color(random(255),random(255),random(255)), // color lletra
                 width/2, // posicio incial x
                 height, // posicio incial y
                 random(20, 100), // velocitat
                 radians(random(35,145)), //angle surtida
                 10 // acceleració
                 ));
  }

}


void draw() {
  
  // dibuixem fondo
  background(0, 0, 0);

  // si l'ArrayList te elements recorreguem aquest
  if (bombas.size()>0){

        for (int i = 0; i < bombas.size(); ++i) {
            Bomba currentBomb = bombas.get(i);
            currentBomb.draw_bomba(); // mustrem la bomba
            currentBomb.update_bomba(); // canviem posició bomba

            // comprovem si la bomba a sortit de la pantalla
            // si es així eliminem l'element del ArrayList
            if(currentBomb.get_position()){
              bombas.remove(i);
            };
        }

  } else {
    // si l'array no té elements demanem al usuari que apreti una tecla per afegir-ne
    fill(255);
    textAlign(CENTER);
    text("Press a key to throw letters", width/2, height/2);
  }

};

// classe del objecte bomba
class Bomba{


  char bomba_lletra; // lletra que es dispararà
  int bomba_size; // mida lletra
  color bomba_color; // color de la lletra

  float bomba_y; // posició actual rodona, eix x
  float bomba_x; // posició actual rodona, eix y

  float bomba_x0; // posició inicial rodona, eix x
  float bomba_y0; // posició incial rodona, eix y

  float time; // temps
  float v_0; // velocitat incial
  float angle; // angle
  float a ; // acceleració o gravetat

  //constructor de l'objecte, amb els seus parámetres definitoris
  Bomba(int c_size, color c_color, int c_x0, int c_y0, float c_v, float c_angle, float c_a){

      String abecedario = "abcdefghijklmnopqrstvwxyzABCDEFGHIJKLMNOPQRSTVWXYZ";
      bomba_lletra = abecedario.charAt(int(random(abecedario.length())));
      bomba_size = c_size;
      bomba_color = c_color;

      bomba_x0 = c_x0;
      bomba_y0 = c_y0;
      bomba_x = bomba_x0;
      bomba_y = bomba_y0;

      v_0 = c_v; 
      angle = c_angle; 
      a = c_a; 
      time = 0;
  }

  // update, calcul nova posició
  void update_bomba(){
    bomba_x = bomba_x0 + v_0*cos(angle)*time ;
    bomba_y = bomba_y0 - v_0*sin(angle)*time +a/2*sq(time) ;
    time = time + 0.07;
  }

  // draw, visualització bomba
  void draw_bomba(){
    fill (bomba_color);
    //ellipse (bomba_x, bomba_y, bomba_radi, bomba_radi);
    textAlign(CENTER);
    textSize(bomba_size);
    text(bomba_lletra, bomba_x, bomba_y);
  }

  // comproba si l'element esta fora de pantalla
  boolean get_position(){
    if (bomba_x < -20 || bomba_x > width+20 || bomba_y > height+10) {
      return true;
    } else {
      return false;
    }
  }

}


// si sapreta l'espai s'afegeix un element al array
void keyPressed() {

  bombas.add(new Bomba(
                 int(random(15, 30)), //mida lletra
                 color(random(255),random(255),random(255)), // color lletra
                 width/2, // posicio incial x
                 height, // posicio incial y
                 random(20, 100), // velocitat
                 radians(random(35,145)), //angle surtida
                 10 // acceleració
                         ));
}
