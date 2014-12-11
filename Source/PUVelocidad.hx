package ;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Bitmap;
import engine.*;
/**
 * ...
 * @author ...
 */
class PUVelocidad extends PowerUp {

	private var factorIncremento:Float;
	
	public function new(scene:RunnerScene, namePower:String, speed:Float, efectoPU:Int) {
		super(scene, namePower, speed, efectoPU);
		bitmapPower = new Bitmap(Assets.getBitmapData(namePower));
		this.addChild(bitmapPower);
		factorIncremento = 2;
		tiempoEfecto = efectoPU;
	}
	
	override public function consumir() {
		SoundManager.getInstance().playSound("powerup");
		desaparecer();
		aplicarEfecto();
		Timer.delay(quitarEfecto, tiempoEfecto * 1000);
	}
	
	override public function aplicarEfecto() {
		powerActivo = true;
		escena.incrementarVelocidad(factorIncremento);
	}

	override public function quitarEfecto() {
		if (powerActivo) escena.decrementarVelocidad(factorIncremento);
		powerActivo = false;
		
	}
	
}