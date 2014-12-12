package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import engine.*;

class HastaElMaipo extends engine.SceneManager {

	private var soundManager:SoundManager;
	private static var instance:SceneManager = null;
	
	public static function getInstance():SceneManager{
		return instance;
	}

	public function new () {
		super();
		instance=this;

		stage.addEventListener(flash.events.Event.ENTER_FRAME,gameLoop);
		InputManager.getInstance().suscribe(stage);


		//Seteo las escenas

		sceneMap.set('empresa', new Empresa());
		sceneMap.set('game', new GameScene());	//¿Por que hay dos "game" con dos intancias distintas?
		sceneMap.set('game', new RunnerScene());

		
		//Seteo las escenas

		sceneMap.set('empresa', new Empresa());
		sceneMap.set('game', new GameScene());
		sceneMap.set('intro', new IntroScene());

		sceneMap.set('pausa', new PauseScene());
		sceneMap.set('menu', new MenuScene());
		sceneMap.set('die', new DieScene());
		sceneMap.set('win', new WinScene());
		
		sceneMap.set('boss', new BossScene());
		//sceneMap.set('help',new HelpScene());
		
		//Empiezo el juego
		setScene('win');
		
		//Seteo los sonidos
		soundManager = SoundManager.getInstance();
		soundManager.addSound("main", Assets.getSound ("main"));
		soundManager.addSound("die", Assets.getSound ("die"));
		soundManager.addSound("powerup", Assets.getSound ("powerup"));
		soundManager.addSound("fall", Assets.getSound ("fall"));
		soundManager.addSound("enemydie", Assets.getSound ("enemydie"));
		
		stage.addEventListener(openfl.events.Event.RESIZE,onResize);

	}
	
	public function onResize(_){
		var s:Float = Math.min(stage.stageWidth/720, stage.stageHeight/400);
		this.scaleX = this.scaleY = s;
		this.x = (stage.stageWidth - 720 * s) / 2;
		this.y = (stage.stageHeight - 400 * s) / 2;
	}
	
	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		this.updateLogic(1/60);
	}
		
}
