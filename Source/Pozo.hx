package ;

import openfl.Assets;
import engine.*;

//Pozo y enemigo son casi lo mismo, cambia su imagen (podria ser parametrizado) y la forma en la que aparecen.
//Pozo aparece por debajo de zulma, enemigo aparece a la altura de zulma.

class Pozo extends GameElement {

	var pozo:Animation;
	var escena:GameScene;
	var velocidad:Float;
	
	public function new (scene:GameScene, speed:Float) {
		super();
		pozo = new Animation(Assets.getBitmapData("images/pozo.png"), 1, 1);
		this.addChild(pozo);
		this.hijos.push(pozo);
		escena = scene;
		velocidad = speed;		
	}
	
	public function desaparecer(){
		estado = 0;
		escena.pozos.push(this);
		escena.pozosActivos.remove(this);
		escena.hijos.remove(this);
		escena.removeChild(this);		
	}

	public function aparecer(){
		this.x = 1500;
		this.y = escena.height - 52;//1 pendejesimo de mas para que pueda haber colision!
		this.estado = 1;
		escena.hijos.push(this);
		escena.addChild(this);
		escena.pozosActivos.push(this);
	}
	
	override public function updateLogic(time:Float){
		if (estado == 0) return;
		super.updateLogic(time);
		this.x -= time * velocidad;
		if (this.x < -100) 
			desaparecer();
	}

	public function incrementarVelocidad(nuevaVel:Float) {
		velocidad *= nuevaVel;
	}
	
	public function decrementarVelocidad(nuevaVel:Float) {
		velocidad /= nuevaVel;
	}
	
}