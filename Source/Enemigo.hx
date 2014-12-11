package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

//TODO: 
//Parametrizar velocidad
//Agregar Callback
//Pasar todos los metodos a castellano

class Enemigo extends GameElement{
	
	var volando:Animation;
	var escena:GameScene;
	var numero:Int;
	var velocidad:Float;
	
	public function new (scene:GameScene, speed:Float) {
		super();
		numero = Std.random(4) + 1;
		volando = new Animation(Assets.getBitmapData("images/enemigo"+numero+".png"), 1, 1);
		this.addChild(volando);
		this.hijos.push(volando);
		escena = scene;
		velocidad = speed;
	}

	public function morir(){
		estado=0;
		escena.enemigos.push(this);
		escena.enemigosActivos.remove(this);
		escena.hijos.remove(this);
		escena.removeChild(this);		
	}

	public function atacar(){
		this.x = 1500;
		this.y = escena.height - this.height - 36;//51 es la altura del piso
		this.estado=1;
		escena.hijos.push(this);
		escena.addChild(this);
		escena.enemigosActivos.push(this);
	}
	
	override public function updateLogic(time:Float){
		if (estado == 0) return;
		super.updateLogic(time);
		this.x -= time * velocidad;
		if (this.x < -100) 
			morir();
	}

	public function incrementarVelocidad(nuevaVel:Float) {
		velocidad *= nuevaVel;
	}
	
	public function decrementarVelocidad(nuevaVel:Float) {
		velocidad /= nuevaVel;
	}
	
}
