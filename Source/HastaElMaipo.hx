package;

import flash.display.Sprite;
import flash.Lib;
import flash.display.Bitmap;
import openfl.Assets;
import engine.*;
import openfl.media.SoundChannel;

class HastaElMaipo extends engine.SceneManager {

	
	private var backgroundMusic:SoundChannel;
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
		sceneMap.set('game', new GameScene());
		sceneMap.set('pausa', new PauseScene());
		sceneMap.set('game',new RunnerScene());
		sceneMap.set('menu', new MenuScene());
		sceneMap.set('die', new DieScene());
		
		sceneMap.set('boss', new BossScene());
		//sceneMap.set('help',new HelpScene());
		
		//Empiezo el juego
		setScene('empresa');
		
		//Seteo los sonidos
		soundManager = SoundManager.getInstance();
		soundManager.addSound("main", Assets.getSound ("main"));
		soundManager.addSound("tic", Assets.getSound ("tic"));
		
		stage.addEventListener(openfl.events.Event.RESIZE,onResize);
		//Le doy play a la banda sonora del juego
		//backgroundMusic = Assets.getSound("main").play(0, 100, null);
		
		//Al carajo la musica hasta nuevo aviso
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
