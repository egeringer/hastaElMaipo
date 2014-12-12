package ;
import engine.*;
import openfl.Assets;
/**
 * ...
 * @author ...
 */

class Boss extends GameElement {
	
	var imagen:Animation;
	var escena:BossScene;
	var alturaSalto:Float;
	var cantVidas:Int;
	
	var tiempoDisparo:Float;

	//Posibles parametros: 	* numero de boss (para cargar el sprite correspondiente).
	//						* cantidad de vidas con las que cuenta.
	public function new(scene:BossScene) {
		super();
		escena = scene;
		//Cambiar sprite enemigo
		imagen = new Animation(Assets.getBitmapData("images/boss.png"), 4, 1);
		
		this.addChild(imagen);
		this.x = 600;
		this.y = escena.height - this.height - 51; //51 es la altura del piso.
		hijos.push(imagen);
		alturaSalto = 12;
		cantVidas = 5;
		
		tiempoDisparo = 0;
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		
		if (tiempoDisparo > 0)
			tiempoDisparo -= time;
		
		if (tiempoDisparo <= 0) {
			tiempoDisparo = 1.5;
			var hayDisparo:Int = Std.random(2);
			if (hayDisparo == 1) {
				var bb = BossBala.getBossBala();
				if (bb != null) {
					bb.x = this.x;
					bb.y = this.y;
				}
			}
		}
		
		var haySalto:Int = Std.random(3);
		if (haySalto == 1) {
			this.y -= alturaSalto * 0.5;
			alturaSalto -= 0.5;
			if (alturaSalto == -12) {
				estado = 0;
				alturaSalto = 12;
				this.y += 12 * 0.5;
			}
		}
	}
	
	public function decrementarVidas() {
		cantVidas--;
	}
	
	public function isAlive() {
		if (cantVidas > 0)
			return true;
		return false;
	}
	
	public function resetVidas() {
		cantVidas = 5;
	}

}