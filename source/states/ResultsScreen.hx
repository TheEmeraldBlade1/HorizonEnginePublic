package states;

class ResultsScreen extends MusicBeatState
{
    var missedTxt:FlxText;
    var resultsCharacter:FlxSprite;

    public static var misses:Int = 0;

    override function create()
    {
        misses = Misses.returnMiss();
        FlxG.sound.playMusic('assets/music/resultsNORMAL' + TitleState.soundExt);

        Cursor.createCursor();

        var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/RESULTS/yellow.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

        resultsCharacter = new FlxSprite(490, 140);
		resultsCharacter.frames = FlxAtlasFrames.fromSparrow('assets/images/RESULTS/RESULTS_BOYFRIEND_GOOD_RANK.png', 'assets/images/RESULTS/RESULTS_BOYFRIEND_GOOD_RANK.xml');
		resultsCharacter.animation.addByPrefix('intro', "intro", 24);
		resultsCharacter.animation.addByPrefix('loop', "loop", 24);
		resultsCharacter.animation.play('loop');
		resultsCharacter.scrollFactor.set(0.4, 0.4);
		resultsCharacter.antialiasing = true;
        add(resultsCharacter);

        var sick:FlxSprite = new FlxSprite().loadGraphic('assets/images/RESULTS/missed.png');
		sick.antialiasing = true;
        sick.x = 150;
		add(sick);

        missedTxt = new FlxText(sick.x - 50, sick.y + 20, 0, Std.string(misses), 12);
		missedTxt.scrollFactor.set();
		missedTxt.setFormat("assets/fonts/5by7.ttf", 22, FlxColor.PURPLE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(missedTxt);
        super.create();
    }
    override function update(elapsed:Float)
    {
        /*if (FlxG.mouse.overlaps(resultsCharacter) && FlxG.mouse.pressed) // THIS WAS DONE TO GET THE OFFSETS DONT USE THIS
			{
				// HOW THE FUCK DO I CONVERT THIS
				resultsCharacter.x = -Math.round(FlxG.mouse.x - resultsCharacter.frameWidth * 1.5);
				resultsCharacter.y = -Math.round(FlxG.mouse.y - resultsCharacter.frameHeight * 1.5);
				// TO MOUSE MOVEMENT?????????
                trace("x: " + resultsCharacter.x + ", y:" + resultsCharacter.y);
			}*/
        if (controls.ACCEPT)
         {
            Cursor.unloadCursor();
            FlxG.sound.music.stop();
            FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
            FlxG.switchState(new FreeplayState());
        }
        super.update(elapsed);
    }
}