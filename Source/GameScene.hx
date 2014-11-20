package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
/**
 * ...
 * @author fbricker
 */
class GameScene extends Scene {

	private var zulma:Zulma;
	public var enemigos(default,null):Array<Enemigo>;
	public var enemigosActivos(default,null):Array<Enemigo>;
	private var fondo1:FondoAnimado;
	private var fondo2:FondoAnimado;
	private var fondo3:FondoAnimado;
	private var fondo4:FondoAnimado;
	private var enemyTimer:Float;
	var backBtn:Boton;
	
	//Agregado Cristian
	public var powerUps(default, null):Array<PowerUp>;
	var powerTimer:Float;
	//FIN Agregado Cristian

	public function new () {
		super();

		backBtn=new Boton(0xFFFFFF,20,20,"images/pausa.png",function(_){HastaElMaipo.getInstance().setScene('menu');} );

		fondo1 = new FondoAnimado('images/bkg-4.png', 2);
		fondo2 = new FondoAnimado('images/bkg-3.png', 10);
		fondo3 = new FondoAnimado('images/bkg-2.png', 70);
		fondo4 = new FondoAnimado('images/bkg-1.png', 70);
		
		addChild(fondo1);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		hijos.push(fondo1);
		hijos.push(fondo2);
		hijos.push(fondo3);
		hijos.push(fondo4);
		
		//Agregado Cristian
		powerUps = new Array<PowerUp>();
		for (i in 0 ... 1) {
			powerUps.push(new PowerUp(this, "images/power_defense.png", 200));
			powerUps.push(new PowerUp(this, "images/power_velocity.png", 200));
		}
		powerTimer = 0;
		//FIN Agregado Cristian

		enemigos=new Array<Enemigo>();
		enemigosActivos=new Array<Enemigo>();
		//Cargo los enemigos
		for (i in 0 ... 10) enemigos.push(new Enemigo(this));
		zulma = new Zulma(this);
		
		// Los coloco en Pantalla
		this.addChild(zulma);
		hijos.push(zulma);

		enemyTimer=0;

		addChild(backBtn);
	}

	override public function updateLogic(time:Float){
		super.updateLogic(time);
       	       	
		enemyTimer-=time;

		if(enemyTimer<0){
			enemyTimer=Std.random(3)+2;
			if(enemigos.length>0) enemigos.pop().atack();
		}
		
				//Agregado Cristian
		powerTimer -= time;
		if (powerTimer < 0) {
			powerTimer = Std.random(5) + 5;
			if (powerUps.length > 0)
				powerUps.pop().show();
		}
       	
	}

    // Detecta si obj1 y obj2 colisionan por el metodo mas simple de todos.
    public static function detectarColision(obj1:GameElement,obj2:GameElement):Bool{
		if(obj1.x+obj1.width>obj2.x && obj1.x<obj2.x+obj2.width){
		   	if(obj1.y+obj1.height>obj2.y && obj1.y<obj2.y+obj2.height){
		   		return true;
		   	}
		}
		return false;
    }
		
}
