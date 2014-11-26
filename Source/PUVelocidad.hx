package ;

import openfl.Assets;
import openfl.display.Bitmap;
/**
 * ...
 * @author ...
 */
class PUVelocidad extends PowerUp {

	private var factorIncremento:Int;
	
	public function new(scene:GameScene, namePower:String, speed:Float) {
		super(scene, namePower, speed);
		bitmapPower = new Bitmap(Assets.getBitmapData(namePower));
		this.addChild(bitmapPower);
		factorIncremento = 5;
	}
	
	override public function aplicarEfecto() {
		escena.fondo1.vel *= factorIncremento;
		escena.fondo2.vel *= factorIncremento;
		escena.fondo3.vel *= factorIncremento;
		escena.fondo4.vel *= factorIncremento;
		for (enemigo in escena.enemigos)
			enemigo.velocidad *= factorIncremento;
		for (enemigo in escena.enemigosActivos)
			enemigo.velocidad *= factorIncremento;		
	}

	override public function quitarEfecto() {
		escena.fondo1.vel /= factorIncremento;
		escena.fondo2.vel /= factorIncremento;
		escena.fondo3.vel /= factorIncremento;
		escena.fondo4.vel /= factorIncremento;
		for (enemigo in escena.enemigos)
			enemigo.velocidad /= factorIncremento;
		for (enemigo in escena.enemigosActivos)
			enemigo.velocidad /= factorIncremento;		
	}
	
}