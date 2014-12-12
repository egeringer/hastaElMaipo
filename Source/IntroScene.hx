package ;

import engine.*;
import flash.display.Bitmap;
import motion.Actuate;
import openfl.Assets;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.media.SoundChannel;

/**
 * ...
 * @author ...
 */
class IntroScene extends GameScene {
	
	var goToGame:Boton;
	var dialogo:Bitmap;
	var texto_zulma1:TextField;
	var texto_zulma2:TextField;
	var texto_zulma3:TextField;
	var texto_zulma4:TextField;
		
	private var zulma_cantando:SoundChannel;
	private var zulma_gritando:SoundChannel;
	
	var enemigo1:Bitmap;
	var enemigo2:Bitmap;
	var enemigo3:Bitmap;
	
	private var backgroundMusic:SoundChannel;
	
	public function new() {
		super();
	}
	
	override function initScene() {
		
		goToGame = new Boton(0xFFFFFF, 120, 43, "images/skip-boton.png", function(_) { ir_menu(); } );
		
		fondo1 = new FondoAnimado('images/bkg-4.png', 0);
		fondo3punto5 = new FondoAnimado('images/bkg-3-5.png', 20);
		fondo2 = new FondoAnimado('images/bkg-3.png', 0);
		fondo3 = new FondoAnimado('images/bkg-2.png', 0);
		fondo4 = new FondoAnimado('images/bkg-1.png', 0);
		
		dialogo = new Bitmap(Assets.getBitmapData("images/dialogo-box.png"));
		dialogo.x = 41;
		dialogo.y = 130;
		dialogo.alpha = 1;
		
		goToGame.x = 600;
		goToGame.y = 0;
		
		addChild(fondo1);
		addChild(fondo3punto5);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);
		addChild(dialogo);

		hijos.push(fondo3punto5);

		zulma = new Zulma(this);
		addChild(zulma);
		zulma.setParada();
		addChild(goToGame);
		
		/*Enemigo*/
		enemigo1 = new Bitmap(Assets.getBitmapData("images/en1_intro.png"));
		enemigo2 = new Bitmap(Assets.getBitmapData("images/en2_intro.png"));
		enemigo3 = new Bitmap(Assets.getBitmapData("images/en3_intro.png"));
		
		enemigo1.x = 650;
		enemigo2.x = 680;
		enemigo3.x = 700;
		enemigo1.y = 240;
		enemigo2.y = 240;
		enemigo3.y = 240;
		enemigo1.alpha = enemigo2.alpha = enemigo3.alpha = 0;
		
		addChild(enemigo1);
		addChild(enemigo2);
		addChild(enemigo3);
		
		/*Sonidos*/
		zulma_cantando = null;
		zulma_gritando = null;
		
		/*Textos*/
		var tf=new TextFormat('fonts/OratorStd.otf',16,0x000000);		
		
		texto_zulma1 = new TextField();
		texto_zulma1.selectable=false;
		texto_zulma1.width=620;
		texto_zulma1.height=40;
		texto_zulma1.setTextFormat(tf);
		texto_zulma1.defaultTextFormat=tf;
		texto_zulma1.text='Hoy es mi gran noche en el Maipo. Estoy hecha una princesa,'+ '\n' +'con peluca nueva, dientes nuevos...';
		this.addChild(texto_zulma1);
		texto_zulma1.x =50;
		texto_zulma1.y = 150;

		texto_zulma2 = new TextField();
		texto_zulma2.selectable=false;
		texto_zulma2.width=620;
		texto_zulma2.height=40;
		texto_zulma2.setTextFormat(tf);
		texto_zulma2.defaultTextFormat=tf;
		texto_zulma2.text='Tengo una voz divina... parate que te canto algo.';
		this.addChild(texto_zulma2);
		texto_zulma2.x =120;
		texto_zulma2.y = 150;
		
		texto_zulma3 = new TextField();
		texto_zulma3.selectable=false;
		texto_zulma3.width=620;
		texto_zulma3.height=40;
		texto_zulma3.setTextFormat(tf);
		texto_zulma3.defaultTextFormat=tf;
		texto_zulma3.text='Ay, parece que atraje a un grupo de fans...';
		this.addChild(texto_zulma3);
		texto_zulma3.x =60;
		texto_zulma3.y = 150;
		
		texto_zulma4 = new TextField();
		texto_zulma4.selectable=false;
		texto_zulma4.width=620;
		texto_zulma4.height=40;
		texto_zulma4.setTextFormat(tf);
		texto_zulma4.defaultTextFormat=tf;
		texto_zulma4.text='ME ROBARON TODO, AUXILIOOOO';
		this.addChild(texto_zulma4);
		texto_zulma4.x =220;
		texto_zulma4.y = 160;
		
		texto_zulma1.alpha = 0;	
		texto_zulma2.alpha = 0;	
		texto_zulma3.alpha = 0;
		texto_zulma4.alpha = 0;
		
	}
	
	override public function show() {
		//motion.Actuate.tween(dialogo, 2, { alpha:1 },false ).delay(0);
		
		//textos + cancion resistire
		motion.Actuate.tween(texto_zulma1, 1, { alpha:1 }, false ).delay(0);
		motion.Actuate.tween (texto_zulma1, 2, { alpha: 0 }, false).delay(4);	
		
		motion.Actuate.tween(texto_zulma2, 1, { alpha:1 } ).delay(5).onComplete(function() reproducir_tema("resistire"));
		motion.Actuate.tween (texto_zulma2, 2, { alpha: 0 }, false).delay(41);
		
		motion.Actuate.tween(texto_zulma3, 1, { alpha:1 } ).delay(42);
		motion.Actuate.tween (texto_zulma3, 2, { alpha: 0 }, false).delay(45);	

		motion.Actuate.tween(dialogo, 2, { alpha:0 }, false ).delay(45);
		
		//enemigos(3) se tiran encima y zulma gritando
		motion.Actuate.tween (enemigo1, 2, { alpha:1, x:40, y:240 }, false ).delay(45).onComplete(function() reproducir_tema("gritando")); //grito
		motion.Actuate.tween( enemigo2, 2, { alpha:1, x:50, y:240 }, false ).delay(46);
		motion.Actuate.tween (enemigo3, 2, { alpha:1, x:60, y:240 }, false ).delay(47);
		
		motion.Actuate.tween (enemigo1, 2, { alpha:0, x:0, y:240 }, false ).delay(48);
		motion.Actuate.tween( enemigo2, 2, { alpha:0, x:0, y:240 }, false ).delay(49);
		motion.Actuate.tween (enemigo3, 2, { alpha:0, x:0, y:240 }, false ).delay(50);
		
		//zulma dice que le robaron todo .onComplete(ir menu)
		motion.Actuate.tween(dialogo, 2, { alpha:1 }, false ).delay(51);
		motion.Actuate.tween (texto_zulma4, 2, { alpha: 1 }, false).delay(51).onComplete (function() ir_menu());	
		}	 
	
		private function reproducir_tema(sonido:String) {
			if (HastaElMaipo.getInstance().getScene()=="intro")
				if (sonido=="resistire")
					zulma_cantando = Assets.getSound("resistire").play();
				else
					zulma_gritando = Assets.getSound("zulma_gritando").play();
			}
			
			private function ir_menu() {
				if (zulma_cantando!=null)
					zulma_cantando.stop();
				if (zulma_gritando!=null)
					zulma_gritando.stop();
				//Le doy play a la banda sonora del juego
				backgroundMusic = Assets.getSound("main").play(0, 100, null);
				HastaElMaipo.getInstance().setScene('menu');
				}
			
	override public function updateLogic(time:Float) {
		super.updateLogic(time);		
	}
}