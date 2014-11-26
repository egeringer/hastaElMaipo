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
		sceneMap.set('game',new GameScene());
		sceneMap.set('menu', new MenuScene());
		sceneMap.set('die', new DieScene());
		//sceneMap.set('help',new HelpScene());
		
		//Empiezo en la escena del Menu
		setScene('menu');
		
		
		//Seteo los sonidos
		soundManager = SoundManager.getInstance();
		soundManager.addSound("main", Assets.getSound ("main"));
		soundManager.addSound("tic", Assets.getSound ("tic"));
		
		
		//Le doy play a la banda sonora del juego
		backgroundMusic = Assets.getSound("main").play(0, 0, null);
	}

	// Nuestro gameLoop (se ejecuta antes de cada cuadro).
	function gameLoop(e){
		this.updateLogic(1/60);
	}
		
}
