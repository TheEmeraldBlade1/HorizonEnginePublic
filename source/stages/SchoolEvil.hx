package stages;

import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;

class SchoolEvil extends FlxGroup
{
    public function new()
    {
        super();
        var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
        var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);

        var posX = 400;
        var posY = 200;

        var bg:FlxSprite = new FlxSprite(posX, posY);
        bg.frames = FlxAtlasFrames.fromSparrow('assets/images/weeb/animatedEvilSchool.png', 'assets/images/weeb/animatedEvilSchool.xml');
        bg.animation.addByPrefix('idle', 'background 2', 24);
        bg.animation.play('idle');
        bg.scrollFactor.set(0.8, 0.9);
        bg.scale.set(6, 6);
        add(bg);
    }
}