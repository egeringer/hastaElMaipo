package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import flash.media.Sound;
import engine.*;
import openfl.text.TextField;
import openfl.text.TextFormat;

class DieScene extends Scene {
	var fondo:Bitmap;
	var reintentar:Boton;
	var irMenu:Boton;
	var puntaje:TextField;


	public function new(){
		super();
		
		fondo = new Bitmap(Assets.getBitmapData("images/game-over.jpg"));	
		reintentar=new Boton(0xFF0000,300,100,"images/repeat.png",play);
		irMenu=new Boton(0x00FF00,300,100,"images/home.png",goToMenu);
		
		this.addChild(fondo);
		this.addChild(reintentar);
		this.addChild(irMenu);
		
		reintentar.x=80;
		reintentar.y = 200;
		reintentar.width = reintentar.height = 100;

		irMenu.x=460;
		irMenu.y = 200;
		irMenu.width = irMenu.height = 100;
		
		fondo.x = 50;
		fondo.y = 50;
				
		puntaje = new TextField();
		puntaje.selectable=false;
		puntaje.width=300;
		puntaje.height=100;
		var tf=new TextFormat('fonts/showtime.ttf',30,0xFFFFFF);
		puntaje.setTextFormat(tf);
		puntaje.defaultTextFormat=tf;

		this.addChild(puntaje);
		
	}

	public function play(_){
		HastaElMaipo.getInstance().setScene('game');
	}

	public function goToMenu(_){
		HastaElMaipo.getInstance().setScene('menu');
	}

	override public function show() {
		puntaje.text='MAX SCORE: '+Persistence.getScore();
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