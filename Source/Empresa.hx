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
			
		empresa.x = this.height;
		empresa.y = this.width;
	}

	override public function show() {
		empresa.alpha = 0;	
		motion.Actuate.tween(empresa, 8, { alpha:1 } );
		motion.Actuate.tween (empresa, 8, { alpha: 0 }, false).onComplete (function() HastaElMaipo.getInstance().setScene('menu'));	

		
	}	       	
	
}