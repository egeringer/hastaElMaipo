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
	var scene:GameScene;
	var numero:Int;
	
	public function new (scene:GameScene) {
		super();
		numero = Std.random(4) + 1;
		volando = new Animation( Assets.getBitmapData("images/brainy_idle_"+numero+".png"), 1, 8);
		this.addChild(volando);
		this.hijos.push(volando);
		this.scene=scene;
	}

	public function die(){
		estado=0;
		scene.enemigos.push(this);
		scene.enemigosActivos.remove(this);
		scene.hijos.remove(this);
		scene.removeChild(this);		
	}

	public function atack(){
		this.x=1000;
		this.y=scene.height-this.height-40;
		this.estado=1;
		scene.hijos.push(this);
		scene.addChild(this);
		scene.enemigosActivos.push(this);
	}
	
	override public function updateLogic(time:Float){
		if(estado==0) return;
		super.updateLogic(time);
		x-=time*200;
		if(x<-100) die();
	}

}
