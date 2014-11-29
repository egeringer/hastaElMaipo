package ;
import engine.GameElement;
import openfl.Assets;
import openfl.display.Bitmap;

class PowerUp extends GameElement {
	
	var escena:RunnerScene;
	var bitmapPower:Bitmap;
	var velocidad:Float;
	
	var tiempoEfecto:Int;
	
	public function new(scene:RunnerScene, namePower:String, speed:Float, efectoPU:Int) {
		super();
		escena = scene;
		velocidad = speed;
	}
	
	public function desaparecer() {
		escena.powerUps.push(this);
		escena.hijos.remove(this);
		escena.removeChild(this);
		escena.powersActivos.remove(this);
	}
	
	public function mostrar() {
		this.x = 1500;
		this.y = escena.height-this.height-51 - Std.random (Std.random(200));//51 es la altura del piso
		escena.hijos.push(this);
		escena.addChild(this);
		escena.powersActivos.push(this);
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		this.x -= time * velocidad;
		if (this.x < -100)
			desaparecer();
	}
	
	public function aplicarEfecto() {}
	public function quitarEfecto() {}
	public function consumir() {}
	
}