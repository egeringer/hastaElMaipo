package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

class GameScene extends Scene {

	private var zulma:Zulma;
	
	public var enemigos(default,null):Array<Enemigo>;
	public var enemigosActivos(default, null):Array<Enemigo>;
	
	public var powerUps(default, null):Array<PowerUp>;
	public var powersActivos(default, null):Array<PowerUp>;
	
	private var backBtn:Boton;
	
	private var fondo1:FondoAnimado;
	private var fondo2:FondoAnimado;
	private var fondo3:FondoAnimado;
	private var fondo3punto5:FondoAnimado;
	private var fondo4:FondoAnimado;
	
	//private var enemyTimer:Float;
	//private var powerTimer:Float;
	private static var puntaje:Int = 0;
	private var estadoDelJuego:Int = 0;
	
	private var timeToBoss:Int = 0;
	private var nextBoss:Int = 200;

	public function new () {
		super();
		initScene();
	}

	private function initScene() {}

					//MOVIDO A CLASE RUNNERSCENE
	//public function incrementarVelocidad(speed:Float) {
		//fondo1.incrementarVelocidad(speed);
		//fondo2.incrementarVelocidad(speed);
		//fondo3.incrementarVelocidad(speed);
		//fondo4.incrementarVelocidad(speed);
		//for (enemigo in enemigos)
			//enemigo.incrementarVelocidad(speed);
		//for (enemigo in enemigosActivos)
			//enemigo.incrementarVelocidad(speed);
	//}
	//
	//public function decrementarVelocidad(speed:Float) {
		//fondo1.decrementarVelocidad(speed);
		//fondo2.decrementarVelocidad(speed);
		//fondo3.decrementarVelocidad(speed);
		//fondo4.decrementarVelocidad(speed);
		//for (enemigo in enemigos)
			//enemigo.decrementarVelocidad(speed);
		//for (enemigo in enemigosActivos)
			//enemigo.decrementarVelocidad(speed);
	//}
	
	public function personajeInmune() {
		zulma.setInmunidad();
	}
	
	public function incrementarVidaPersonaje() {
		zulma.incrementarVidas();
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		
		if (estadoDelJuego == 3 ) {
			
			for (power in powersActivos) {
				power.quitarEfecto();
			}
			for (power in powerUps) {
				power.quitarEfecto();
			}
			HastaElMaipo.getInstance().setScene('die');
		}

		puntaje++;
		Persistence.setScore(puntaje);
		
		//timeToBoss++;
		//trace(timeToBoss);
		if (timeToBoss == nextBoss) {
			timeToBoss = 0;
			nextBoss += nextBoss;
			HastaElMaipo.getInstance().setScene('boss');
			trace("boss");
		}
		
						//MOVIDO A CLASE RUNNERSCENE
		//enemyTimer -= time;
		//if (enemyTimer < 0) {
			//enemyTimer = Std.random(3) + 2;
			//if (enemigos.length > 0) 
				//enemigos.pop().atacar();
		//}
		//
		//powerTimer -= time;
		//if (powerTimer < 0) {
			//powerTimer = Std.random(5) + 2;
			//if (powerUps.length > 0)
				//powerUps.pop().mostrar();
		//}
       	
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
