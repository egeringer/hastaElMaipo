package engine;

import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.TouchEvent;
import flash.events.MouseEvent;

class InputManager {
	
	var teclas:Array<Bool>;
	
	private static var instance:InputManager=null;
	
	public static function getInstance():InputManager{
		if(instance==null){
			instance=new InputManager();
		}
		return instance;
	} 
	
	private function new () {
		teclas=new Array<Bool>();
		
	}
	
	public function suscribe(stage:Stage){
		// Suscribo los Eventos para el Teclado
		stage.addEventListener(flash.events.KeyboardEvent.KEY_UP, onKeyUp);
		stage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, onKeyDown);
	
		//stage.addEventListener(flash.events.TouchEvent.TOUCH_TAP, onTouch);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		//stage.addEventListener(flash.events.TouchEvent.TOUCH_TAP, onTouch);
	}

	// Cuando se Suelta una Tecla
    private function onKeyUp(event:KeyboardEvent){
    	teclas[event.keyCode]=false;
    }

	// Cuando se Presiona una Tecla
    private function onKeyDown(event:KeyboardEvent){
		teclas[event.keyCode]=true;
    }
    
    public function keyPressed(key:String):Bool{
    	return teclas[key.charCodeAt(0)];    
    }	
	
	//jugando con el mouse y el touch
	
	private function onMouseDown(event:MouseEvent){
			teclas[1]=true;
	}
	private function onMouseUp(event:MouseEvent){
			teclas[1]=false;
	}
	public function mousePressed():Bool {
		return teclas[1]; }
	
	
	//public function onTouch(event: TouchEvent){
			//trace("Me tocaron");
	//}
	

}
