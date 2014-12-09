package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
import openfl.text.TextField;
import openfl.text.TextFormat;
import motion.Actuate;

class PauseScene extends Scene {

	var continuar:Boton;
	var marquee:Animation;
	
	private var fondo1:FondoAnimado;
	private var fondo2:FondoAnimado;
	private var fondo3:FondoAnimado;
	private var fondo3punto5:FondoAnimado;
	private var fondo4:FondoAnimado;
	
	public function new(){
		super();
		
		//REMOVER TODO ESTO Y PONERLO EN ALGUN LADO EN COMUN
		fondo1 = new FondoAnimado('images/bkg-4.png', 0);
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
		

		continuar=new Boton(0xFF0000,300,100,"images/menu-continuar.png",volver_juego);
		marquee = new Animation(Assets.getBitmapData("images/menu-marquee.png"), 2, 1);

		
		this.addChild(marquee);
		this.addChild(continuar);
		
		hijos.push(marquee);
		
		marquee.x = 20;
		marquee.y = 15;
		
		continuar.x=175;
		continuar.y=230;
	
		}

	public function volver_juego(_){
		HastaElMaipo.getInstance().setScene('game');
	}

	override public function show() {				
	}

}