package objects.ui;

import openfl.display.BlendMode;
import openfl.display.BitmapData;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

using StringTools;

class NoteSplash extends FlxSprite{

    public static var splashPath:String = "noteSplashes";
    public var colorSwap:ColorSwap;

    public function new(x:Float, y:Float, note:Int){

        super(x, y);

        colorSwap = new ColorSwap();
		shader = colorSwap.shader;

		colorSwap.hue = FlxG.save.data.arrowHSV[note % 4][0] / 360;
		colorSwap.saturation = FlxG.save.data.arrowHSV[note % 4][1] / 100;
		colorSwap.brightness = FlxG.save.data.arrowHSV[note % 4][2] / 100;
        
        var noteColor:String = "purple";
        switch(note){
            case 0:
                noteColor = "purple";
            case 1:
                noteColor = "blue";
            case 2:
                noteColor = "green";
            case 3:
                noteColor = "red";
        }

        frames = FlxAtlasFrames.fromSparrow('assets/images/notesplash/' + noteColor + '.png', 'assets/images/notesplash/' + noteColor + '.xml');
        antialiasing = true;
        animation.addByPrefix("splash", "splash", 24 + FlxG.random.int(-3, 4), false);
        animation.finishCallback = function(n){ kill(); }
        animation.play("splash");

        alpha = 0.6;

        switch(splashPath){
            default:
                updateHitbox();
                offset.set(width * 0.3, height * 0.3);
                angle = 0;

        }

        //blend = BlendMode.SCREEN;

    }

}