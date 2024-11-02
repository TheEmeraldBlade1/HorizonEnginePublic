package stages;

class Spooky extends FlxGroup
{
    public var halloweenBG:FlxSprite;
    public function new()
    {
        super();
        var hallowTex = FlxAtlasFrames.fromSparrow('assets/images/halloween_bg.png', 'assets/images/halloween_bg.xml');

        halloweenBG = new FlxSprite(-200, -100);
        halloweenBG.frames = hallowTex;
        halloweenBG.animation.addByPrefix('idle', 'halloweem bg0');
        halloweenBG.animation.addByPrefix('lightning', 'halloweem bg lightning strike', 24, false);
        halloweenBG.animation.play('idle');
        halloweenBG.antialiasing = true;
        add(halloweenBG);
    }
    
    public function onLightningStrikeShit():Void
    {
        halloweenBG.animation.play('lightning');
    }
}