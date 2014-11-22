package engine;

/**
 * ...
 * @author egeringer
 */

 import flash.media.Sound;
 
class SoundManager
{
	private var soundMap(default, null):Map<String,Sound>;
	
	private static var instance:SoundManager;
  
  	public static inline function getInstance()
  	{
    	if (instance == null)
          return instance = new SoundManager();
      	else
          return instance;
  	}
        
	private function new(){
		soundMap = new Map<String,Sound>();
	}

	public function addSound(name:String,sound:Sound) {
		soundMap.set(name, sound);
	}
	
	public function playSound(name:String) {
		if (soundMap.exists(name)) {
			soundMap.get(name).play();}
		else
			trace("SOUND "+name+" NOT FOUND");
		}
		
		
}