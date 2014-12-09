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

class MenuScene extends Scene {

	var jugar:Boton;
	var ayuda:Boton;
	var titulo:Bitmap;
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
		

		jugar=new Boton(0xFF0000,300,100,"images/menu-jugar.png",play);
		ayuda = new Boton(0x00FF00, 300, 100, "images/menu-ayuda.png", help);
		marquee = new Animation(Assets.getBitmapData("images/menu-marquee.png"), 2, 1);
		titulo = new Bitmap(Assets.getBitmapData("images/menu-titulo.png"));
		
		this.addChild(marquee);
		this.addChild(titulo);
		this.addChild(jugar);
		this.addChild(ayuda);
		
		hijos.push(marquee);
		
		titulo.x = 50;
		titulo.y = 185;
		
		marquee.x = 20;
		marquee.y = 15;
		
		jugar.x=285;
		jugar.y=265;

		ayuda.x=310;
		ayuda.y=310;
	
		}

	public function play(_){
		HastaElMaipo.getInstance().setScene('game');
	}

	public function help(_){
		HastaElMaipo.getInstance().setScene('help');
	}

	override public function show() {		
		//motion.Actuate.tween(title, 3, { positionX:positionX + 1, positionY:positionY + 1 } );
		
		/*
		jugar.scaleX=jugar.scaleY=20;
		jugar.alpha=0;
		motion.Actuate.tween(jugar,0.2,{scaleX:1,scaleY:1,alpha:1});

		ayuda.rotation=2000;
		ayuda.alpha=0;
		motion.Actuate.tween(ayuda,3,{rotation:0,alpha:1}).delay(0.3);
		*/
		
	}

}