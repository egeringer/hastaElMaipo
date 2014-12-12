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
		imagen = new Animation(Assets.getBitmapData("images/arma-boss-1.png"), 6, 1);
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
		if (this.x < -100) {
			desaparecerBossBala(this);
		}
		
		if (GameScene.detectarColision(this, escena.zulma)) {
			escena.zulma.decrementarVidas();
			desaparecerBossBala(this);
			if (!escena.zulma.isAlive()) {
				Persistence.setVidas(1);
				SoundManager.getInstance().playSound("die");
				escena.setEstado(3); /*Estado perdi*/
			}
		}
		
	}
	
	public static function desaparecerBossBala(bb:BossBala) {
		pool.push(bb);
		bb.visible = false;
		bb.imagen.visible = false;
	}
	
}