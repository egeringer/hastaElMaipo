package ;

import engine.*;
/**
 * ...
 * @author ...
 */
class IntroScene extends GameScene {
	
	public function new() {
		super();
	}
	
	override function initScene() {
		
		//backBtn = new Boton(0xFFFFFF, 20, 20, "images/pausa.png", function(_) { setEstado(2);/*Pausado*/ HastaElMaipo.getInstance().setScene('menu'); } );
		//boton de ir a menu para sacar la animacion
		
		fondo1 = new FondoAnimado('images/bkg-4.png', 0);
		fondo3punto5 = new FondoAnimado('images/bkg-3-5.png', 20);
		fondo2 = new FondoAnimado('images/bkg-3.png', 0);
		fondo3 = new FondoAnimado('images/bkg-2.png', 0);
		fondo4 = new FondoAnimado('images/bkg-1.png', 0);
		
		addChild(fondo1);
		addChild(fondo3punto5);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		//hijos.push(fondo1);
		hijos.push(fondo3punto5);
		//hijos.push(fondo2);
		//hijos.push(fondo3);
		//hijos.push(fondo4);
		//
		zulma = new Zulma(this);
		addChild(zulma);
		//hijos.push(zulma);
		//addChild(backBtn);
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);		
	}
}