/**
	David Vinagre Cerezo
	Assignatura: Física per multimedia
	PRAC FINAL
*/

// declarem els elements/variables de l'aplicació

// projectil inicial
Projectil projectil0;
// projectil1 resultat de l'explosió 
Projectil projectil1;
// projectil1 resultat de l'explosió
Projectil projectil2; 

// posició origen de coordenades
// reticula que serveix com ajuda visual
// a més canvia la posició de l'origen de coordenades
Graella graella1;


// string on s'enmagazema el text d'ajuda
String textAyuda;


void setup(){
	size(800, 600, JAVA2D);
	smooth(4);
	frameRate(30);

	// inicialitzem objectes
	// inicialitzem graella
	graella1 = new Graella(width/2, height*3/4);

	// text d'ajuda que es mostra al iniciar la aplicació
	textAyuda = "Clica el botó esquerra del ratolí";

	// inicialitzem projectils
	// projectil inicial
	projectil0 = new Projectil(
		5.0, 			// pes
		color(0,0,255)	// color
	);
	// projectils resultat explosió
	projectil1 = new Projectil(
		2.0,			
		color(255,0,0)
	);
	// 2n projectil
	// la massa es calcula mitjançant una funció
	projectil2 = new Projectil(
		calculPesProjectil2(projectil0.getMassa(),projectil1.getMassa()),
		color(0,255,0)
	);

	// donem valors d'inici al projectils
	projectil0.esVisible(true); 							// es mostra
	projectil0.setPosicio(new PVector(0.0, 0.0));		// posicio inicial
	projectil0.setVelocitat(new PVector(0.0, 90.0));	// velocitat inicial

	projectil1.esVisible(false); // no es mostra
	projectil2.esVisible(false);
}


void draw(){
	// dibuixa cuadrícula
	// canvia els eixos de coordenada
	graella1.display();
	
	// mostra o no els projectils
	projectil0.display();
	projectil2.display();
	projectil1.display();

	// actualitza: posicio, velocitat dels projectils
	projectil0.update();
	projectil2.update();
	projectil1.update();

	// mostra el text d'ayuda
	textAyuda(textAyuda);
}


// accio que s'executa quan es fa click amb el ratolí
void mouseClicked() {

	// si poryectil0 es visible
	if (projectil0.getVisible()){
		// ocultem projectil0 i motrem projectil1 i projectil2 
		projectil0.esVisible(false);
		projectil1.esVisible(true);
		projectil2.esVisible(true);

		// pasem les dades de posició 
		projectil1.setPosicio(projectil0.getPosicio());
		// pasem les dades de velocitat al projectil1
		// calculVelocitatProjectil1()métode que calcula velocitat proyectil1
		projectil1.setVelocitat(
			calculVelocitatProjectil1( 
				projectil0.getVelocitat()
				)
			);

		// pasem les dades de posició al proyectil2
		projectil2.setPosicio(projectil0.getPosicio());
		// pasem les dades de velocitat al proyectil2
		// calculVelocitatProjectil2()métode que calcula velocitat proyectil2
		projectil2.setVelocitat(
			calculVelocitatProjectil2(
				projectil0.getVelocitat(),
				projectil0.getMassa(),
				projectil1.getVelocitat(),
				projectil1.getMassa(),
				projectil2.getMassa()
				)
			);

		// generem el text d'ajuda.
		textAyuda = "EXPLOSIO\n"+"Moment: "+projectil0.getTemps()+" s\n";
		textAyuda += "Alçada: "+projectil0.getPosicio().y+" m\n\n"; 
		textAyuda += "PROJECTIL 0\nVel. ("+projectil0.getVelocitat().x+", "+projectil0.getVelocitat().y+") m/s\n";
		textAyuda += "Massa "+projectil0.getMassa()+"Kg \n";
		textAyuda += "PROJECTIL 1\nVel. ("+projectil1.getVelocitat().x+", "+projectil1.getVelocitat().y+") m/s\n";
		textAyuda += "Massa "+projectil1.getMassa()+"Kg \n";
		textAyuda += "PROJECTIL 2\nVel. ("+projectil2.getVelocitat().x+", "+projectil2.getVelocitat().y+") m/s\n";
		textAyuda += "Massa "+projectil2.getMassa()+"Kg \n";

	} else {
		// si esclica un altre cop el ratolí
		// ocultem projectil1 i proyectil2 i mostrem projectil0
		projectil0.esVisible(true);
		projectil1.esVisible(false);
		projectil2.esVisible(false);
		
		// passem les dades d'inici del proyectil 0
		projectil0.setPosicio(new PVector(0.0, 0.0));
		projectil0.setVelocitat(new PVector(0.0, 90.0));

		// tornem a generar el text d'ajuda
		textAyuda = "Torna a clicar el botó esquerre del ratolí.";
	}


}

// funció que retorna la velocitat del Proyectil1
// a partir de la velocitat del proyectil0
PVector calculVelocitatProjectil1(PVector velProjectil0){
	return new PVector(30, -velProjectil0.y/2); 
}


// funció que retorna la velocitat del Proyectil2
// a partir de:
// 		velocitat proyectil0
//		massa proyectil0
//		velocitat proyectil1
//		massa proyectil1
//		massa proyectil2
PVector calculVelocitatProjectil2(
	PVector velProj0,
	float massaProj0,
	PVector velProj1,
	float massaProj1,
	float massaProj2
	){

	PVector velProj2 = new PVector(); 

	// calcul X del vector velocitat
	// m1 * v1 = (m2 * v2) + (m3 * v3);
	velProj2.x = ((massaProj0 * velProj0.x) - (massaProj1 *velProj1.x)) / massaProj2;

	// calcul y
	velProj2.y =  ((massaProj0 * velProj0.y) - (massaProj1 *velProj1.y)) / massaProj2;

	return velProj2;
}

// funció que retorna el pes del projectil 2 a partir del pes dels
// altres proyectils
float calculPesProjectil2(float massaProj0, float massaProj1){
	return massaProj0 - massaProj1;
}



/*
 CLASSE Projectil
*/
class Projectil{

	// constants, son valors que no es poden canviar
	final float incrementTemps = 1.0/30.0;  // 1s dividit entre el frameRate
	final PVector gravetat = new PVector(0,-9.8); // m/s

	// variables
	float massa;
	PVector posicio;
	PVector velocitat;
	color colorProjectil;
	float temps;


	// variable boleana que permet mostrar o ocultar
	boolean visible = false;

	// constructor
	Projectil(float c_massa, color c_colorProjectil){
		posicio = new PVector();
		velocitat = new PVector();
		massa = c_massa;
		colorProjectil = c_colorProjectil;

		temps = 0.0;
	}

	// funcio que actualitza posició y velocitat
	void update(){
		if(visible){

			// actualitzem posicio sumant velocitat
			// posicio = posicioInicial + (velocitat * temps)
			posicio.x += (velocitat.x * incrementTemps);
			posicio.y += (velocitat.y * incrementTemps);

			// actualitzem velocitat amb la gravetat
			// velocitat = velocitatIncial + (acceleracio * temps)
			velocitat = velocitat.add(
				gravetat.x * incrementTemps,
				gravetat.y * incrementTemps);
	 		
	 		temps += incrementTemps;

		} 
	}

	// métode que dibuixa el projectil si es visible
	void display(){
		if(visible){
			ellipseMode(CENTER);
			noStroke();
			fill(colorProjectil);
			ellipse(posicio.x, posicio.y, massa*2, massa*2);
		}
	}

	// getters: retornan els valors de l'objecte
	PVector getVelocitat(){
		return velocitat;
	};

	PVector getPosicio(){
		return posicio;
	};

	float getMassa(){
		return massa;
	};

	boolean getVisible(){
		return visible;
	};

	float getTemps(){
		return temps;
	}

	// setters: canvien els valors de l'ojecte
	void setVelocitat(PVector c_velocitat){
		velocitat.set(c_velocitat);
	};

	void setPosicio(PVector c_posicio){
		posicio.set(c_posicio);
	};

	void esVisible(boolean c_visible){
		visible = c_visible;
	};

};


/*
 CLASSE Graella
 classe que crea una graella d'un gràfic
 a més de canviar el sistema de coordenades per defecte de processing
 per un més facil d'utilitzar, d'aquesta manera no he de canviar els valors
 de l'enunciat per tal que la simulació sigui realista.
*/
class Graella{

	// origen de coordenadas
	PVector origen;

	Graella(float x_origen, float y_origen){
		origen = new PVector(x_origen, y_origen);
	};

	void display(){

		background(20);

		// dibuixem linees
		for (int i = 0; i < origen.y; i+=10) {
			if(i%100==0){
				stroke(100);
			} else{
				stroke(40);
			};
			line(0, origen.y-i, width, origen.y-i);

		};

		for (int i = 0; i < width; i+=10) {
			
			if(i%100==0 && i!=origen.x){
				stroke(100);
			} else if(i==origen.x){
				stroke(150);
			} else{
				stroke(40);
			}
			line(i, height, i, 0);
		};

		fill(0, 50);
		rect(0, origen.y, width, height-origen.y);

		// mostrem valors gràfica
		fill(255);
		textAlign(RIGHT);
		textSize(9);

		for (int i = 0; i < origen.y; i+=100) {
				text(i+"m", origen.x-5, origen.y-i);
		};

		textAlign(CENTER);
		for (int i = 0; i < width; i+=100) {
			if(i!=origen.x){
				stroke(100);
				text(int(i-origen.x)+"m", i, origen.y+10);
			}; 
		};

		// Canviem origen del sistema de coordenades
		translate(origen.x, origen.y);
		// Canviem sentit coordenades
		scale(1, -1);

	};
};


// text d'ayuda
// funció que mostra un text d'ajuda

void textAyuda(String c_textAyuda){
	rotate(radians(180));
	scale(-1,1);

	fill(0, 200);
	rect(-375, -420, 200, 290);
	fill(255);
	textSize(12);
	textAlign(LEFT);
	text(c_textAyuda, -370, -410, 190, 380);

}

