/*
  PAC 3 Física per a Multimedia
  Exercici 5
  David Vinagre Cerezo
*/

/*
  NOTES:
  A l'enunciat de l'exercici es demana que "La corda ha d'estar composta per un mínim de 20 partícules"
  jo ho he volgut fer mitjançant línies contínues. Tot i així si entenem que una línia és
  una sucesió de punts en l'espai, llavors el resultat s'adequa perfectament amb l'enunciat.
*/


// declaración de la variable que contindrá l'objecte ona1
Ona ona1; 


// funció de configuració
void setup() {
  size(600, 400); // mida pantalla
  frameRate (30); // 30 frames per segon

  /*
    construcció de l'objecte ona1
    a la vegada que el construïm li passem els paràmetres que defineixen l'ona
    punt d'equilibri, l'ongitud d'ona, freqüencia, amplitud i color traç
  */
  ona1 = new Ona(
    height/2,       // punt equilibri ona                        (puntEquilibri)
                    // la variable "height" és l'altura de la pantalla
    200.0,          // longitud d'ona en pixeles                 (longitudOna)
    1.0,            // frequencia HZ, número cicles per segons   (frequenciaOna)
    60.0,           // amplitud ona en píxels                    (amplitudOna)
    color(0,0,0)    // color del dibuix de l'ona                 (colorOna)
    );

}

// funció que s'executa a cada frame
void draw() {
  
  background(160);      // donem color al fons

  // dibuixem una línea que mostra el punt d'equilibri de la gràfica
  ona1.mostraLineaEquilibri();

  // crida al métode que dibuixa l'ona
  ona1.draw_ona();    
  
  // crida al métode que mostra els valor de l'ona
  ona1.valorsOna();   

  // crida al métode que actualitza els valors de l'ona
  // en aquest cas només s'actualitza el temps
  ona1.update_ona();
  
};

// classe del objecte bomba
class Ona{

  /*
   atributs de l'objecte
   s'utilitzen valors float ja que al calcular el valor de y
   dona com a resultat valors decimals
   es declaren tots els valors necesaris per dibuixar la línia
  */

  float puntEquilibri;    // punt equilibri ona
  float longitudOna;      // longitud ona
  float frequenciaOna;    // frequencia ona
  float periodeOna;       // frequencia ona
  float amplitudOna;      // amplitud ona
  float t;                // temps

  color colorOna;         // color ona


  //constructor de l'objecte, amb els seus parámetres definitoris
  Ona(
    float c_puntEquilibri,
    float c_longitudOna,
    float c_frequenciaOna,
    float c_amplitudOna,
    color c_colorOna
    ){
    // Assignació valors (atributs constructor) a atributs objecte
    puntEquilibri = c_puntEquilibri;
    longitudOna = c_longitudOna;
    frequenciaOna = c_frequenciaOna;
    amplitudOna = c_amplitudOna;
    colorOna = c_colorOna;

    // calculem el periode a partir de la freqüència
    // es necesari per a la funció de calcul de la "y" a la funció calcularYOnaHarmonica(valorX, valorT)
    periodeOna = 1.00/frequenciaOna;

    // iniciem el valor de t (temps) a 0 en un primer moment
    t = 0.00; 
  }

  // métode que actualitza el temps
  void update_ona(){
    /*
     al temps inicial li sumem l'increment de temps
     aquest està calculat a partir del frameRate
     d'aquesta manera ens asegurem que el programa funcioni bé independentment del
     frameRate utilitzat
    */
    t += 1.00/frameRate;
  }   


  // metode que dibuixa l'ona
  void draw_ona(){
    /*
      aquesta funció recorre tots els valors de les "x"
      i assigna un valor de "y" per cada valor de "x"
      utilitzant la funció calcularYOnaHarmonica(valorX, valorT)
      Per fer-ho gràficament més atractiu en comptes d'utilitzar punts
      s'han utilitzat línies que uneixen els diferents punts, d'aquesta manera
      crec que és més cómode de visualitzar.
    */

    // inicialitzem variable del valor de y
    float y;

    /*
     valors de "x,y inicials"
     ho necesitem per poder dibuixar la primera línia,
     ja que una línia necesita 4 valors mínims per poder dibuixar-la:
     line(x1, y1, x2, y2);
    */
    // inciem valor "x inicial", aquest es troba fora de la pantalla
    int x0 = -1; 
    // inciem valor "y inicial " utilitzant la funció calcularYOnaHarmonica(float v_x, float v_t)
    // aquesta funció retorna un valor float el convertim a enter amb la funcio int() 
    int y0 = int(this.calcularYOnaHarmonica(-1.0,t)); 

    // valor de color de la línia
    stroke(colorOna);  // s'utilitza el color que passem com a parámetre a l'objecte

    /*
      loop que recorre tots els valors possibles de les x
      que van des del 0 al 600
      la variable "width" té el valor d'ample de la pantalla,
      aquest valor l'otorguem quan iniciem el valor de la pantalla a void setup() amb la funció:
      size(amplePantalla, alçadaPantalla)
    */
    for (int x = 0; x <= width; ++x) {    
      /*
         calculem el valor de la y segons x i temps aixó és equivalent a:
         y = puntEquilibri + (amplitudOna * sin(TWO_PI * (x/longitudOna - t/periodeOna)));
         però com que també s'utilitza per calcular la "y0" es passa a funció
         utilitzem el métode "this." per cridar una funció que està dintre del mateix objecte
      */
      y = this.calcularYOnaHarmonica(float(x),t);

      /* 
        dibuixem la línia
        també ho prodriem dibuixar amb punts o amb altres formes (com cercles)
        par dibuixar-ho amb punts utilitzariem l'expressió
        point(x, int(y));
      */
      line(x0, y0, x, y);
    
      // assignem els nous valors a "x, y inicials" per poder dibuixar la següent línea
      x0 = x;
      y0 = int(y);
    }

  }

  /*
    métode que retorna el valor de y a partir dels parametres:
      v_x -> valor x
      v_t -> valor temps

    és la mateixa funció que apareix a l'enunciat:
      y(x,t) = y0 + A sin[2π(x/⋋ - t/T)]
    on
      y0 = puntEquilibri
      A = amplitudOna
      x = v_x -> valor x
      ⋋ = longitudOna
      t = v_t -> temps
      T = periodeOna

    només es pot cridar dintre de l'objecte per això el "private"  
  */
  private float calcularYOnaHarmonica(float v_x, float v_t){
    return (puntEquilibri + (amplitudOna * sin(TWO_PI * (v_x/longitudOna - v_t/periodeOna))));
  }


  /*
    métode que dibuixa la línea d'equilibri
    només té funcionalitat estética
  */
  void mostraLineaEquilibri(){
    stroke(180);                                    // color línea
    line(0, puntEquilibri, width, puntEquilibri);   // dibuixem línea
  }

  /*
    métode que escriu els paràmetres de lona:
    longitud d'ona, freqüencia, amplitud i temps

    només té funcionalitat estética, però a l'hora de desenvolupar l'aplicació 
    m'ha servit per tenir clars quins valors es passaven a la funció calcularYOnaHarmonica()
  */
  void valorsOna(){
      fill(255); // color del text
      // text a mostrar 
      text("Longitud ona: "+int(longitudOna)
            +"px | Freqüència: "+int(frequenciaOna)
            +"Hz | Amplitud: "+int(amplitudOna)
            +"px | Temps: "+t+"s",
            20, 30); // els 2 últims parámetres corresponen a la posició del text
  }

}


