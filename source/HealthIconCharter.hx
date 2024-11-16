package;

import flixel.FlxSprite;

class HealthIconCharter extends FlxSprite
{
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		loadGraphic('assets/images/charter/iconGrid.png', true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('dad', [12, 13], 0, false, isPlayer);
		animation.play(char);
		scrollFactor.set();
	}
}
