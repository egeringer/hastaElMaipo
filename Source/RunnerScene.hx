package ;

import engine.*;
/**
 * ...
 * @author ...
 */
class RunnerScene extends GameScene {

	private var enemyTimer:Float;
	private var powerTimer:Float;
	
	public function new() {
		super();
	}
	
	override function initScene() {
		
		setEstado(1); /*Jugando*/

		backBtn = new Boton(0xFFFFFF, 20, 20, "images/pausa.png", function(_) { setEstado(2);/*Pausado*/ HastaElMaipo.getInstance().setScene('menu'); } );

		fondo1 = new FondoAnimado('images/bkg-4.png', 2);
		fondo3punto5 = new FondoAnimado('images/bkg-3-5.png', 30);
		fondo2 = new FondoAnimado('images/bkg-3.png', 10);
		fondo3 = new FondoAnimado('images/bkg-2.png', 70);
		fondo4 = new FondoAnimado('images/bkg-1.png', 70);
		
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
		for (i in 0 ... 4) {
			//powerUps.push(new PUDefensa(this, "images/power_defense.png", 280, 18));
			//powerUps.push(new PUVelocidad(this, "images/power_velocity.png", 280, 10));
			powerUps.push(new PUVida(this, "images/power_life.png", 280, 1));
		}
		powerTimer = 0;

		enemigos = new Array<Enemigo>();
		enemigosActivos = new Array<Enemigo>();
		for (i in 0 ... 10) 
			enemigos.push(new Enemigo(this, 300));
		enemyTimer = 0;
		
		zulma = new Zulma(this);
		addChild(zulma);
		hijos.push(zulma);
		addChild(backBtn);
		
		timeToBoss = 0;
		nextBoss = 2000;
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
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
		enemyTimer -= time;
		if (enemyTimer < 0) {
			enemyTimer = Std.random(3) + 2;
			if (enemigos.length > 0) 
				enemigos.pop().atacar();
		}
		
		powerTimer -= time;
		if (powerTimer < 0) {
			powerTimer = Std.random(30) + 2;
			if (powerUps.length > 0)
				powerUps.pop().mostrar();
		}
	}
	
}