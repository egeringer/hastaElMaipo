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
class DieScene extends Scene {

	var jugar:Boton;
	var ayuda:Boton;
	var title:Bitmap;

	public function new(){
		super();
		
		title = new Bitmap(Assets.getBitmapData("images/perdiste.png"));
			
		jugar=new Boton(0xFF0000,300,100,"images/jugar.png",play);
		ayuda=new Boton(0x00FF00,300,100,"images/ayuda.png",help);
		
		this.addChild(title);
		this.addChild(jugar);
		this.addChild(ayuda);

		title.x = 0;
		title.y = 0;
		
		jugar.x=0;
		jugar.y=200;

		ayuda.x=400;
		ayuda.y=200;
	}

	public function play(_){
		HastaElMaipo.getInstance().setScene('game');
	}

	public function help(_){
		HastaElMaipo.getInstance().setScene('help');
	}

	override public function show() {
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