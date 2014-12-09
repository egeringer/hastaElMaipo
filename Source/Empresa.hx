 package ;

import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;

import engine.*;

class Empresa extends Scene
{
	var empresa:Bitmap;

	public function new(){
		super();
		
		empresa = new Bitmap(Assets.getBitmapData("images/logo.png"));
		this.addChild(empresa);
		
		empresa.height = 200;
		empresa.width = 200;
			
		empresa.x = 250;
		empresa.y = 100;
	}

	override public function show() {
		empresa.alpha = 0;	
		motion.Actuate.tween(empresa, 8, { alpha:1 } );
		motion.Actuate.tween (empresa, 2, { alpha: 0 }, false).delay(2).onComplete (function() HastaElMaipo.getInstance().setScene('menu'));	
		}	       	
	
}