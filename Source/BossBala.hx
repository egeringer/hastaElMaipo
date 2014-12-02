package ;
import engine.*;
import openfl.Assets;
/**
 * ...
 * @author ...
 */
class BossBala extends GameElement {

	var imagen:Animation;
	static var pool:Array<BossBala> = null;
	static private var escena:BossScene;
	
	public function new() {
		super();
		imagen = new Animation(Assets.getBitmapData("images/power_life.png"), 1, 1);
		this.addChild(imagen);
		hijos.push(imagen);
		visible = false;
	}
	
	public static function init(scene:BossScene) {
		if (pool == null) {
			BossBala.escena = scene;
			pool = new Array<BossBala>();
			for(i in 0 ... 7) {
				var bb = new BossBala();
				escena.hijos.push(bb);
				escena.addChild(bb);
				pool.push(bb);
			}
		}
	}
	
	public static function getBossBala():BossBala {
		if (pool.length > 0) {
			var bb = pool.pop();
			bb.visible = true;
			bb.imagen.visible = true;
			return bb;
		}
		return null;
	}

	override public function updateLogic(time:Float) {
		if (!visible) 
			return;
		super.updateLogic(time);
		
		this.x -= 200 * time;
		//for (enemigo in escena.enemigosActivos) {
			//if (GameScene.detectarColision(this, enemigo)) {
				//imagen.visible = false;
				//pool.push(this);
				//enemigo.morir();
				//this.visible = false;
			//}	
		//}
		if (this.x < -100) {
			//trace ("se guardo bala boss");
			pool.push(this);
			this.visible = false;
			this.imagen.visible = false;
		}
	}
	
}