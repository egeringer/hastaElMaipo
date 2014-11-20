package ;
import engine.GameElement;
import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author ...
 */
class PowerUp extends GameElement {
	
	var scene:GameScene;
	var bitmapPower:Bitmap;
	var velocity:Float;
	
	public function new(escena:GameScene, nombrePower:String, velocidad:Float) {
		super();
		scene = escena;
		velocity = velocidad;
		bitmapPower = new Bitmap(Assets.getBitmapData(nombrePower));
		this.addChild(bitmapPower);
	}
	
	public function die() {
		scene.powerUps.push(this);
		scene.hijos.remove(this);
		scene.removeChild(this);
	}
	
	public function show() {
		this.x = 1000;
		this.y = Std.random(300);
		
		scene.hijos.push(this);
		scene.addChild(this);
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		this.x -= time * velocity;
		if (this.x < -100)
			die();
	}
	
}