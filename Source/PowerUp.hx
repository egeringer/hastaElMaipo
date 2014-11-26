package ;
import engine.GameElement;
import openfl.Assets;
import openfl.display.Bitmap;

class PowerUp extends GameElement {
	
	var escena:GameScene;
	var bitmapPower:Bitmap;
	var velocidad:Float;
	
	public function new(scene:GameScene, namePower:String, speed:Float) {
		super();
		escena = scene;
		velocidad = speed;
		bitmapPower = new Bitmap(Assets.getBitmapData(namePower));
		this.addChild(bitmapPower);
	}
	
	public function consumir() {
		escena.powerUps.push(this);
		escena.hijos.remove(this);
		escena.removeChild(this);
		escena.powersActivos.remove(this);
	}
	
	public function mostrar() {
		this.x = 1000;
		this.y = Std.random (Std.random(200)) + 200;
		escena.hijos.push(this);
		escena.addChild(this);
		escena.powersActivos.push(this);
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		this.x -= time * velocidad;
		if (this.x < -100)
			consumir();
	}
	
}