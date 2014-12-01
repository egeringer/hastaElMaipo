package ;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Bitmap;
/**
 * ...
 * @author ...
 */
class PUVida extends PowerUp {

	public function new(scene:RunnerScene, namePower:String, speed:Float, efectoPU:Int) {
		super(scene, namePower, speed, efectoPU);
		bitmapPower = new Bitmap(Assets.getBitmapData(namePower));
		this.addChild(bitmapPower);
		tiempoEfecto = efectoPU;
	}
	
	override public function consumir() {
		desaparecer();
		aplicarEfecto();
	}
	
	override public function aplicarEfecto() {
		escena.incrementarVidaPersonaje();
	}
	
}