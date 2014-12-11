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
	var vidasAux:Int;
	var esInmune:Bool;
	var esCorriendo:Bool;
	
	public function new (scene:GameScene) {
		super();
		escena = scene;
		
		caminando = new Animation(Assets.getBitmapData("images/zulma_caminando.png"), 6, 1);	
		corriendo = new Animation(Assets.getBitmapData("images/zulma_corriendo.png"), 6, 1);
		inmune = new Animation(Assets.getBitmapData("images/zulma_defendiendo.png"), 6, 1);
		
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
		
		//Lo siguiente esta mal porque si cerras el juego
		//Te quedan las vidas que tenias, y empezas con eso
		//Pero sirve para compartir las vidas entre el Runner y el Boss Scene.
		cantVidas = Persistence.getVidas();
		if (cantVidas < 1) {
			Persistence.setVidas(1);
		}
	
		salto = 17;
		estado = 0; //Caminando
		esInmune = false;
		esCorriendo = false;
	}
	
	public function setInmunidad() {
		esInmune = !esInmune;
		if (esInmune) {
			this.caminando.alpha = 0;
			this.corriendo.alpha = 0;
			this.inmune.alpha = 1;
		}else {
			this.caminando.alpha = 1;
			this.corriendo.alpha = 0;
			this.inmune.alpha = 0;
		}
	}
	
	public function setCorriendo() {
		esCorriendo = !esCorriendo;
		if (esCorriendo) {
			this.caminando.alpha = 0;
			this.corriendo.alpha = 1;
			this.inmune.alpha = 0;
		}else {
			this.caminando.alpha = 1;
			this.corriendo.alpha = 0;
			this.inmune.alpha = 0;
		}
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
			if (salto == -17) {
				estado = 0;
				salto = 17;
				this.y += 17 * 0.5;
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
		
       	
		// Colision contra enemigos
		for (enemigo in escena.enemigosActivos) {
			if (GameScene.detectarColision(this, enemigo)) {
				enemigo.morir();
				if (esInmune) SoundManager.getInstance().playSound("enemydie");
				else decrementarVidas();
				
				if (!isAlive()) {
					SoundManager.getInstance().playSound("die");
					escena.setEstado(3); /*Estado perdi*/
				}
			}       			
		}
		
		// Colision contra pozos
		for (pozo in escena.pozosActivos) {
			if (GameScene.detectarColision(this, pozo)) {
				SoundManager.getInstance().playSound("fall");
				setVidas(0);
				escena.setEstado(3); /*Estado perdi*/
			}
		}
		
		// Colision contra power-ups
		for (power in escena.powersActivos) {
			if (GameScene.detectarColision(this, power)) {
				SoundManager.getInstance().playSound("powerup");
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
		vidasAux = Persistence.getVidas();
		if (vidasAux > 0)
			return true;
		return false;
	}
	
	public function setVidas(vidasAux:Int) {
		Persistence.setVidas(vidasAux);
		escena.refreshVidas();
	}
	
	public function incrementarVidas() {
		vidasAux = Persistence.getVidas();
		vidasAux++;
		Persistence.setVidas(vidasAux);
		escena.refreshVidas();
	}
	
	public function decrementarVidas() {
		vidasAux = Persistence.getVidas();
		vidasAux--;
		Persistence.setVidas(vidasAux);
		escena.refreshVidas();
	}
	

}
