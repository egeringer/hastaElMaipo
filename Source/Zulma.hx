package ;

import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

class Zulma extends GameElement{
	
	var caminando:Animation;
	
	//Animaciones PowerUps
	var inmune:Animation;
	var corriendo:Animation;
	
	var escena:GameScene;
	var shootTimer:Float;
	var salto:Float;
	var cantVidas:Int;
	var esInmune:Bool;
	
	public function new (scene:GameScene) {
		super();
		escena = scene;
		
		caminando = new Animation(Assets.getBitmapData("images/zulma_corriendo_small.png"), 16, 1);	
		corriendo = new Animation(Assets.getBitmapData("images/zulma_corre.png"), 16, 1);
		inmune = new Animation(Assets.getBitmapData("images/zulma_defensa.png"), 16, 1);
		
		caminando.alpha = 1;
		corriendo.alpha = 0;
		inmune.alpha = 0;
		
		this.addChild(corriendo);
		this.addChild(inmune);
		this.addChild(caminando);
		
		this.x = 50;
		this.y = escena.height - this.height - 51; //51 es la altura del piso.

		hijos.push(caminando);
		hijos.push(corriendo);
		hijos.push(inmune);
		
		shootTimer = 0;
		setVidas(1);
		salto = 15;
		estado = 0; //Caminando
		esInmune = false;
	}
	
	public function setInmunidad() {
		esInmune = !esInmune;
	}
	
	override public function updateLogic(time:Float){
		super.updateLogic(time);
		
		if(InputManager.getInstance().keyPressed('W')){
			if (estado != 1) {
				estado = 1;
			}
		}
		
		if(InputManager.getInstance().mousePressed()){
			if (estado != 1) {
				estado = 1;
			}
		}
		
		if (estado == 1) {
			this.y -= salto * 0.5;
			salto -= 0.5;
			if (salto == -15) {
				estado = 0;
				salto = 15;
				this.y += 15 * 0.5;
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
		
       	if (esInmune) {
			this.caminando.alpha = 0;
			this.inmune.alpha = 1;
		} else {
			this.caminando.alpha = 1;
			this.inmune.alpha = 0;	
		}
		
		//trace(cantVidas + " en la zulma " + this);
		// Colision contra enemigos
		for (enemigo in escena.enemigosActivos) {
			if (GameScene.detectarColision(this, enemigo)) {
				enemigo.morir();
				if (cantVidas > 1 ) {
					if (!esInmune) cantVidas--;
					SoundManager.getInstance().playSound("tic");
				} else {
					escena.setEstado(3); /*Estado perdi*/
				}
			}       			
		}
		
		// Colision contra pozos
		for (pozo in escena.pozosActivos) {
			if (GameScene.detectarColision(this, pozo)) {
				escena.setEstado(3); /*Estado perdi*/
			}
		}
		
		// Colision contra power-ups
		for (power in escena.powersActivos) {
			if (GameScene.detectarColision(this, power)) {
				power.consumir();
			}
		}
		
		//Disparar gato.
		if (InputManager.getInstance().keyPressed('E')) {
			var gb = GatoBala.getGatoBala();
			if (gb != null) {
				//trace ("salio");
				gb.x = this.x;
				gb.y = this.y;
			} 
			//else {
				//trace ("no hay gato");
			//}
		}
		
	}
	
	public function isAlive():Bool {
		if (cantVidas > 0)
			return true;
		return false;
	}
	
	public function setVidas(vidas:Int) {
		cantVidas = vidas;
	}
	
	public function incrementarVidas() {
		cantVidas++;
	}

}
