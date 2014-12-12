package ;

import openfl.display.Sprite;
import engine.*;
import openfl.text.TextField;
import openfl.text.TextFormat;
/**
 * ...
 * @author ...
 */
class RunnerScene extends GameScene {

	private var enemyTimer:Float;
	private var powerTimer:Float;
	private var pozoTimer:Float;
	
	public function new() {
		super();
	}
	
	override function initScene() {
		
		setEstado(1); /*Jugando*/
		
		backBtn = new Boton(0xFFFFFF, 20, 20, "images/pausa.png", function(_) { setEstado(2);/*Pausado*/ HastaElMaipo.getInstance().setScene('pausa'); } );
		
		fondo1 = new FondoAnimado('images/bkg-4.png', 0);
		fondo3punto5 = new FondoAnimado('images/bkg-3-5.png', 30);
		fondo2 = new FondoAnimado('images/bkg-3.png', 10);
		fondo3 = new FondoAnimado('images/bkg-2.png', 70);
		fondo4 = new FondoAnimado('images/bkg-1.png', 300);
		
		addChild(fondo1);
		addChild(fondo3punto5);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		hijos.push(fondo1);
		hijos.push(fondo3punto5);
		hijos.push(fondo2);
		hijos.push(fondo3);
		hijos.push(fondo4);

		powerUps = new Array<PowerUp>();
		powersActivos = new Array<PowerUp>();
						
		powerUps.push(new PUVida(this, "images/power_life.png", 200, 1));
		powerUps.push(new PUVelocidad(this, "images/power_velocity.png", 200, 10));
		powerUps.push(new PUDefensa(this, "images/power_defense.png", 200, 14));
		powerUps.push(new PUVida(this, "images/power_life.png", 200, 1));
		powerUps.push(new PUVelocidad(this, "images/power_velocity.png", 200, 10));
		powerUps.push(new PUDefensa(this, "images/power_defense.png", 200, 14));
		
		powerTimer = 0;

		enemigos = new Array<Enemigo>();
		enemigosActivos = new Array<Enemigo>();
		for (i in 0 ... 10) 
			enemigos.push(new Enemigo(this, 300));
		enemyTimer = 4;
		
		pozos = new Array<Pozo>();
		pozosActivos = new Array<Pozo>();
		for (i in 0 ... 10)
			pozos.push(new Pozo(this, 300));
		pozoTimer = 2;
		
		zulma = new Zulma(this);
		addChild(zulma);
		hijos.push(zulma);
		addChild(backBtn);
		
		//GatoBala.init(this);
		
		timeToBoss = 0;
<<<<<<< HEAD
		nextBoss = 3500; //Aca setea el tiempo hasta el boss
=======
		nextBoss = 1000; //Aca setea el tiempo hasta el boss
>>>>>>> origin/master
		
				
			//VIDAS EN PANTALLA
		vidasPantalla = new TextField();
		vidasPantalla.selectable=false;
		vidasPantalla.width=300;
		vidasPantalla.height=100;
		var tf=new TextFormat('fonts/OratorStd.otf',24,0xFFFFFF);
		vidasPantalla.setTextFormat(tf);
		vidasPantalla.defaultTextFormat=tf;

		this.addChild(vidasPantalla);
		
		vidasPantalla.x = 50;
		vidasPantalla.y = 0;
		
		refreshVidas();
	
	}
	
	public function personajeInmune() {
		zulma.setInmunidad();
	}
	
	public function incrementarVidaPersonaje() {
		zulma.incrementarVidas();
	}
	
	public function incrementarVelocidad(speed:Float) {
		fondo1.incrementarVelocidad(speed);
		fondo2.incrementarVelocidad(speed);
		fondo3.incrementarVelocidad(speed);
		fondo4.incrementarVelocidad(speed);
		for (enemigo in enemigos)
			enemigo.incrementarVelocidad(speed);
		for (enemigo in enemigosActivos)
			enemigo.incrementarVelocidad(speed);
		for (pozo in pozos)
			pozo.incrementarVelocidad(speed);
		for (pozo in pozosActivos)
			pozo.incrementarVelocidad(speed);
		zulma.setCorriendo();
	}
	
	public function decrementarVelocidad(speed:Float) {
		fondo1.decrementarVelocidad(speed);
		fondo2.decrementarVelocidad(speed);
		fondo3.decrementarVelocidad(speed);
		fondo4.decrementarVelocidad(speed);
		for (enemigo in enemigos)
			enemigo.decrementarVelocidad(speed);
		for (enemigo in enemigosActivos)
			enemigo.decrementarVelocidad(speed);
		for (pozo in pozos)
			pozo.decrementarVelocidad(speed);
		for (pozo in pozosActivos)
			pozo.decrementarVelocidad(speed);
		zulma.setCorriendo();
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		enemyTimer -= time;
		if (enemyTimer < 0) {
			enemyTimer = Std.random(6) + 2;
			if (enemigos.length > 0) 
				enemigos.pop().atacar();
		}
		
		powerTimer -= time;
		if (powerTimer < 0) {
			powerTimer = Std.random(12) + 15;
			if (powerUps.length > 0)
				powerUps.pop().mostrar();
		}
		
		pozoTimer -= time;
		if (pozoTimer < 0) {
			pozoTimer = Std.random(10) + 1;
			if (pozos.length > 0)
				pozos.pop().aparecer();
		}
		
		timeToBoss++;
		trace(timeToBoss);
		if (timeToBoss == nextBoss) {
			timeToBoss = 0;
			nextBoss += nextBoss;
			HastaElMaipo.getInstance().setScene('boss');
		}
	}
	
}