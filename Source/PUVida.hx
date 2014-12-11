package ;

import haxe.Timer;
import openfl.Assets;
import openfl.display.Bitmap;
import engine.*;
/**
 * ...
 * @author ...
 */
class PUVida extends PowerUp {

	public function new(scene:RunnerScene, namePower:String, speed:Float, efectoPU:Int) {
		super(scene, namePower, speed, efectoPU);
		bitmapPower = new Bitmap(Assets.getBitmapData(namePower));
		bitmapPower.width = 50;
		bitmapPower.height = 50;
		this.addChild(bitmapPower);
		tiempoEfecto = efectoPU;
	}
	
	override public function consumir() {
		SoundManager.getInstance().playSound("powerup");
		desaparecer();
		aplicarEfecto();
	}
	
	override public function aplicarEfecto() {
		escena.incrementarVidaPersonaje();
	}
	
}