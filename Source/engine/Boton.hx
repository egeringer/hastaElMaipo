package engine;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.display.Bitmap;
import openfl.Assets;

class Boton extends Sprite {
	private var img:Bitmap;
	
	public function new(color:Int, ancho:Int, alto:Int, imagen:String = null, callback:Event->Void) {
		//Falta hacer los cambios necesarios para que en caso de que se pase una imagen, el boton sea una imagen
		super();
		
		if (imagen != null){
			img = new Bitmap(Assets.getBitmapData(imagen));
			this.addChild(img);
			img.x = 0;
		}else{
			this.graphics.beginFill(color);
			this.graphics.drawRect(0,0,ancho,alto);
			this.graphics.endFill();
		}
		this.addEventListener(openfl.events.MouseEvent.CLICK,callback);
	}

}