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
	static private var escena:BossScene;
	
	public function new() {
		super();
		imagen = new Animation(Assets.getBitmapData("images/arma-zulma.png"), 1, 1);
		imagen.scaleX = imagen.scaleY = 0.06;
		this.addChild(imagen);
		hijos.push(imagen);
		visible = false;
	}
	
	public static function init(scene:BossScene) {
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
		
		this.x += 200 * time;
		if (this.x > 900) {
			desaparecerGatoBala(this);
		}
		if (GameScene.detectarColision(this, escena.jefe)) {
			escena.jefe.decrementarVidas();
			desaparecerGatoBala(this);
			if (!escena.jefe.isAlive()) {
				SoundManager.getInstance().playSound("enemydie");
				HastaElMaipo.getInstance().setScene('game');
				escena.jefe.resetVidas();
			}
		}
	}
	
	public static function desaparecerGatoBala(gb:GatoBala) {
		pool.push(gb);
		gb.visible = false;
		gb.imagen.visible = false;
	}
	
}