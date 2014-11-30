package ;
import engine.*;
import openfl.Assets;

/**
 * ...
 * @author ...
 */
class GatoBala extends GameElement {

	var imagen:Animation;
	static var pool:Array<GatoBala> = null;
	static private var escena:RunnerScene;
	
	public function new() {
		super();
		//= new Animation(Assets.getBitmapData("images/zulma_corriendo_small.png"), 16, 1);
		imagen = new Animation(Assets.getBitmapData("images/nyan_cat.png"), 1, 1);
		
		this.addChild(imagen);
		hijos.push(imagen);
		visible = false;
	}
	
	public static function init(scene:RunnerScene) {
		if (pool == null) {
			GatoBala.escena = scene;
			pool = new Array<GatoBala>();
			var gb = new GatoBala();
			escena.hijos.push(gb);
			escena.addChild(gb);

			pool.push(gb);
		}
	}
	
	public static function getGatoBala():GatoBala {
		if (pool.length > 0) {
			var gb = pool.pop();
			gb.visible = true;
			gb.imagen.visible = true;
			return gb;
		}
		return null;
	}
	
	override public function updateLogic(time:Float) {
		if (!visible) 
			return;
		super.updateLogic(time);
		
		this.x += 80 * time;
		//for (enemigo in escena.enemigosActivos) {
			//if (GameScene.detectarColision(this, enemigo)) {
				//imagen.visible = false;
				//pool.push(this);
				//enemigo.morir();
				//this.visible = false;
			//}	
		//}
		if (this.x > 900) {
			pool.push(this);
			this.visible = false;
			this.imagen.visible = false;
		}
	}
	
}