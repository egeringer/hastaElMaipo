package ;

import engine.*;
/**
 * ...
 * @author ...
 */
class BossScene extends Scene {
	
	private var backBtn:Boton;
	public var fondo1:FondoAnimado;
	public var fondo2:FondoAnimado;
	public var fondo3:FondoAnimado;
	public var fondo3punto5:FondoAnimado;
	public var fondo4:FondoAnimado;
	
	private var zulma:Zulma;

	public function new() {
		super();
		backBtn = new Boton(0xFFFFFF, 20, 20, "images/pausa.png", function(_) {HastaElMaipo.getInstance().setScene('menu'); } );
		
		fondo1 = new FondoAnimado('images/bkg-4.png', 0);
		fondo3punto5 = new FondoAnimado('images/bkg-3-5.png', 0);
		fondo2 = new FondoAnimado('images/bkg-3.png', 0);
		fondo3 = new FondoAnimado('images/bkg-2.png', 0);
		fondo4 = new FondoAnimado('images/bkg-1.png', 0);
		
		addChild(fondo1);
		addChild(fondo3punto5);
		addChild(fondo2);
		addChild(fondo3);
		addChild(fondo4);

		hijos.push(fondo1);
		hijos.push(fondo3punto5);
		hijos.push(fondo2);
		hijos.push(fondo3);
		hijos.push(fondo4);
		
		zulma = new Zulma(this);
		addChild(zulma);
		hijos.push(zulma);
	}
	
	override public function updateLogic(time:Float) {
		super.updateLogic(time);
	}
	
}