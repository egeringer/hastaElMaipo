package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

class Zulma extends GameElement{
	
	var caminando:Animation;
	private var inmunidad:Float;
	var scene:GameScene;
	var shootTimer:Float;
	var salto:Float;
	
	public function new (scene:GameScene) {
		super();

		this.scene=scene;
		caminando = new Animation( Assets.getBitmapData ("images/zulma_corriendo_small.png"), 16, 1);
		this.addChild(caminando);
		this.x=50;
		this.y = scene.height - this.height - 40;
		trace(scene.height);
		hijos.push(caminando);
		
		inmunidad=0;
		shootTimer = 0;
		salto = 13;
		estado = 0; //Caminando
	}	
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);

		if(InputManager.getInstance().keyPressed('W')){
			if (estado != 1) {
				estado = 1;
			}
		}else {
			
		}
		
		if (estado == 1) {
			this.y -= salto*0.5;
			salto-=0.5;
			if (salto == -13) {
				estado = 0;
				salto = 13;
				this.y += 13*0.5;
			}
		}
		
		
		/*
		if(InputManager.getInstance().keyPressed('S')){
			this.y++;
			propulsionDown.visible=true;
		}else{
			propulsionDown.visible=false;
		}
		if(InputManager.getInstance().keyPressed('A')){
			propulsion.alpha=0.5;
			x--;
		}else{
			propulsion.alpha=1;
		}
		
		propulsion.visible=true;
		if(InputManager.getInstance().keyPressed('D')){
			propulsionPlus.visible=true;
			propulsion.visible=false;
			x++;
		}else{
			propulsionPlus.visible=false;
		}
       	
		if(shootTimer>0) shootTimer-=time;
		if(shootTimer<=0 && InputManager.getInstance().keyPressed('Q')){
			shootTimer=0.3;
			var b = Bala.getBala();
			if(b!=null){
				b.x=this.x+60;
				b.y=this.y+20;
			}
		}
		*/
       	// Colision contra asteroide e inmunidad post-colision
       	if(inmunidad>0){
       		inmunidad-=time;
       		this.alpha=0.1;
       	}else{
       		this.alpha=1;
       		for(enemigo in scene.enemigosActivos){
		       	if(GameScene.detectarColision(this,enemigo)){
		       		inmunidad=6;
		       		//sound.play();
		       	}       			
       		}
       	}
		
	}

}
