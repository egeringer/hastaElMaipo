package ;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Bitmap;
/**
 * ...
 * @author ...
 */
class PUDefensa extends PowerUp {

	public function new(scene:GameScene, namePower:String, speed:Float, efectoPU:Int) {
		super(scene, namePower, speed, efectoPU);
		bitmapPower = new Bitmap(Assets.getBitmapData(namePower));
		this.addChild(bitmapPower);
		tiempoEfecto = efectoPU;
	}
	
	override public function consumir() {
		desaparecer();
		aplicarEfecto();
		Timer.delay(quitarEfecto, tiempoEfecto * 1000);
	}
	
	override public function aplicarEfecto() {
		escena.personajeInmune();
	}

	override public function quitarEfecto() {
		escena.personajeInmune();
	}
	
}