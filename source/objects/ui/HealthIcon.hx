package objects.ui;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		var tex = getPath(char);
		frames = tex;

		antialiasing = true;
		animation.addByPrefix('norm', 'norm', 24, false);
		animation.addByPrefix('loss', 'loss', 24, false);
		animation.play(char);
		scrollFactor.set();
	}
	public function getPath(path:String)
	{
		return FlxAtlasFrames.fromSparrow('assets/images/icons/' + path + '.png', 'assets/images/icons/' + path + '.xml');
		trace('LOADED ICON: ' + path);
	}
}
