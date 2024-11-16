package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var gameVersion:String = '0.1.1';
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, TitleState, true));
		ScriptHandler.initialize();
	}
}
