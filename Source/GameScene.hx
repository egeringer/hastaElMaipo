package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;

import engine.*;
class GameScene extends Scene {

	private var zulma:Zulma;
	public var enemigos(default,null):Array<Enemigo>;
	public var enemigosActivos(default,null):Array<Enemigo>;
	
	public var fondo1:FondoAnimado;
	public var fondo2:FondoAnimado;
	public var fondo3:FondoAnimado;
	public var fondo4:FondoAnimado;
	
	private var enemyTimer:Float;
	private var backBtn:Boton;
	private static var puntaje:Int=0;
	private var estadoDelJuego:Int = 0;
	//Agregado Cristian
	public var powerUps(default, null):Array<PowerUp>;
	public var powersActivos(default, null):Array<PowerUp>;
	var powerTimer:Float;
	//FIN Agregado Cristian

	public function new () {
		super();
		
		initScene();
		
	}

	private function initScene() {
		
		setEstado(1); /*Jugando*/

		backBtn = new Boton(0xFFFFFF, 20, 20, "images/pausa.png", function(_) { setEstado(2);/*Pausado*/ HastaElMaipo.getInstance().setScene('menu'); } );

		fondo1 = new FondoAnimado('images/bkg-4.png', 2);
		fondo2 = new FondoAnimado('images/bkg-3.png', 10);
		fondo3 = new FondoAnimado('images/bkg-2.png', 70);
		fondo4 = new FondoAnimado('images/bkg-1.png', 70);
		
		addChild(fondo1);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		hijos.push(fondo1);
		hijos.push(fondo2);
		hijos.push(fondo3);
		hijos.push(fondo4);
		
		//Agregado Cristian
		powerUps = new Array<PowerUp>();
		for (i in 0 ... 4) {
			powerUps.push(new PUDefensa(this, "images/power_defense.png", 200, 3));
			powerUps.push(new PUVelocidad(this, "images/power_velocity.png", 200, 3));
		}
		powersActivos = new Array<PowerUp>();
		powerTimer = 0;
		//FIN Agregado Cristian

		enemigos = new Array<Enemigo>();
		enemigosActivos = new Array<Enemigo>();
		//Cargo los enemigos
		for (i in 0 ... 10) enemigos.push(new Enemigo(this, 200));
		zulma = new Zulma(this);
		
		// Los coloco en Pantalla
		this.addChild(zulma);
		hijos.push(zulma);
		enemyTimer=0;
		addChild(backBtn);
	}

	public function incrementarVelocidad(speed:Float) {
		fondo1.incrementarVelocidad(speed);
		fondo2.incrementarVelocidad(speed);
		fondo3.incrementarVelocidad(speed);
		fondo4.incrementarVelocidad(speed);
		for (enemigo in enemigos)
			enemigo.incrementarVelocidad(speed);
		for (enemigo in enemigosActivos)
			enemigo.incrementarVelocidad(speed);
	}
	
	public function decrementarVelocidad(speed:Float) {
		fondo1.decrementarVelocidad(speed);
		fondo2.decrementarVelocidad(speed);
		fondo3.decrementarVelocidad(speed);
		fondo4.decrementarVelocidad(speed);
		for (enemigo in enemigos)
			enemigo.decrementarVelocidad(speed);
		for (enemigo in enemigosActivos)
			enemigo.decrementarVelocidad(speed);
	}
	
	public function personajeInmune() {
		zulma.setInmunidad();
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		
		if (estadoDelJuego == 3 ) {
			HastaElMaipo.getInstance().setScene('die');
		}
       	       	
		puntaje++;
		Persistence.setScore(puntaje);
		enemyTimer -= time;

		if (enemyTimer < 0) {
			enemyTimer = Std.random(3) + 2;
			if (enemigos.length > 0) 
				enemigos.pop().atacar();
		}
		
		//Agregado Cristian
		powerTimer -= time;
		if (powerTimer < 0) {
			powerTimer = Std.random(5) + 2;
			if (powerUps.length > 0)
				powerUps.pop().mostrar();
		}
       	
	}

    // Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    public static function detectarColision(obj1:GameElement,obj2:GameElement):Bool {
		if (obj1.x + obj1.width > obj2.x && obj1.x < obj2.x + obj2.width) {
		   	if (obj1.y + obj1.height > obj2.y && obj1.y < obj2.y + obj2.height) {
		   		return true;
		   	}
		}
		return false;
    }
	
	
	public function resetGame() {
		initScene();
	}
	
	public function setEstado(estado:Int) {
		estadoDelJuego = estado;
	}

	override public function show() {
		if(estadoDelJuego == 3) resetGame();
	}
		
}
