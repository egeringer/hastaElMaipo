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
	var fondo:Bitmap;
	var jugar:Boton;
	var ayuda:Boton;
	var title:Bitmap;

	var minita:Animation;
	
	public function new(){
		super();
		
		fondo = new Bitmap(Assets.getBitmapData("images/maipo.jpg"));
		title = new Bitmap(Assets.getBitmapData("images/title.png"));
		jugar=new Boton(0xFF0000,300,100,"images/jugar.png",play);
		ayuda = new Boton(0x00FF00, 300, 100, "images/ayuda.png", help);
		
		minita = new Animation(Assets.getBitmapData("images/corriendo_nuevo.png"), 13, 1);
		
		minita.x = 10;
		minita.y = 280;
		minita.alpha = 1;
		
		this.addChild(fondo);
		this.addChild(title);
		this.addChild(jugar);
		this.addChild(ayuda);
		
		this.addChild(minita);
		hijos.push(minita);
		
		fondo.x = 0;
		fondo.y = 0;
		
		title.x = 0;
		title.y = 0;
		
		jugar.x=0;
		jugar.y=200;

		ayuda.x=this.width-ayuda.width;
		ayuda.y=200;
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