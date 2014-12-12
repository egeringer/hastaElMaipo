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
	
	private var power1:PowerUp;
	private var power2:PowerUp;
	private var power3:PowerUp;
	private var power4:PowerUp;
	private var power5:PowerUp;
	private var power6:PowerUp;
	
	private var numeroPower:Int;
	
	public function new() {
		super();
	}
	
	override function initScene() {
		
		numeroPower=1;
		
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
						
		power1 = new PUVida(this, "images/power_life.png", 200, 1);
		power2 = new PUVelocidad(this, "images/power_velocity.png", 200, 10);
		power3 = new PUDefensa(this, "images/power_defense.png", 200, 14);
		power4 = new PUVida(this, "images/power_life.png", 200, 1);
		power5 = new PUVelocidad(this, "images/power_velocity.png", 200, 10);
		power6 = new PUDefensa(this, "images/power_defense.png", 200, 14);
		
		
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

		nextBoss = 3500; //Aca setea el tiempo hasta el boss
		
				
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
			powerTimer = Std.random(15) + 2;
			if(numeroPower == 1) power1.mostrar();
			if(numeroPower == 2) power2.mostrar();
			if(numeroPower == 3) power3.mostrar();
			if(numeroPower == 4) power4.mostrar();
			if(numeroPower == 5) power5.mostrar();
			if(numeroPower == 6) power6.mostrar();
			if(numeroPower > 7) powerUps.pop().mostrar();
			numeroPower++;
		}
		
		pozoTimer -= time;
		if (pozoTimer < 0) {
			pozoTimer = Std.random(10) + 1;
			if (pozos.length > 0)
				pozos.pop().aparecer();
		}
		
		timeToBoss++;
		
		if (timeToBoss == nextBoss) {
			timeToBoss = 0;
			nextBoss += nextBoss;
			HastaElMaipo.getInstance().setScene('boss');
		}
	}
	
}