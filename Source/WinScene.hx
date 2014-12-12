package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
import openfl.text.TextField;
import openfl.text.TextFormat;

class WinScene extends Scene {
	var ganaste:Boton;
	var irMenu:Boton;
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

		marquee = new Animation(Assets.getBitmapData("images/menu-marquee.png"), 2, 1);
		ganaste=new Boton(0xFF0000,408,57,"images/ganaste.png",goToMenu);
		irMenu=new Boton(0x00FF00,300,100,"images/menu-ir-home.png",goToMenu);
		
		this.addChild(marquee);
		this.addChild(ganaste);
		this.addChild(irMenu);
		
		hijos.push(marquee);
		
		ganaste.x=160;
		ganaste.y = 210;

		irMenu.x= 250;
		irMenu.y = 287;
				
		marquee.x = 20;
		marquee.y = 15;
		
	}

	public function play(_){
		HastaElMaipo.getInstance().setScene('game');
	}

	public function goToMenu(_){
		HastaElMaipo.getInstance().setScene('menu');
	}

	override public function show() {
		
	}

}