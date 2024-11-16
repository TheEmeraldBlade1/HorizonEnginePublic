package objects.ui;

import openfl.display.BlendMode;
import openfl.display.BitmapData;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

using StringTools;

class NoteSplash extends FlxSprite{

    public var colorSwap:ColorSwap;

    var objectBuild:ForeverModule;
	var exposure:StringMap<Dynamic>;
    public var updateableScript:Array<ForeverModule> = [];
    var splashPath:String = "noteSplashes";
    var rng:FlxRandom = new FlxRandom();

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
        if (FlxG.save.data.splashSkin == 1){
            frames = FlxAtlasFrames.fromSparrow('assets/images/notesplash/forever/' + noteColor + '.png', 'assets/images/notesplash/forever/' + noteColor + '.xml');
            antialiasing = true;
            animation.addByPrefix("splash", "splash", 24 + FlxG.random.int(-3, 4), false);
            animation.finishCallback = function(n){ kill(); }
            animation.play("splash");
        }else if (FlxG.save.data.splashSkin == 2){
            frames = FlxAtlasFrames.fromSparrow('assets/images/notesplash/vanilla/noteSplashes.png', 'assets/images/notesplash/vanilla/noteSplashes.xml');
            antialiasing = true;
            animation.addByPrefix("splash", "note impact " + FlxG.random.int(1, 2) + " " + noteColor, 24 + FlxG.random.int(-3, 4), false);
            animation.finishCallback = function(n){ kill(); }
            animation.play("splash");       
        }else{
            {
                frames = FlxAtlasFrames.fromSparrow('assets/images/notesplash/andromeda/noteSplashes.png', 'assets/images/notesplash/andromeda/noteSplashes.xml');
            }
            antialiasing = true;
            animation.addByPrefix("splash", "note splash " + noteColor + " 1", 24 + FlxG.random.int(-3, 4), false);
            animation.finishCallback = function(n){ kill(); }
            animation.play("splash");
        }
    
        alpha = 0.6;
    
        switch(splashPath){
            default:
                getNoteSplashOffsets();
        }
    
        //blend = BlendMode.SCREEN;

    }

    function getNoteSplashOffsets()
        {
            updateHitbox();
            {
                {
                    {
                        offset.set(width * 0.3, height * 0.3);
                    }
                }
            }
            angle = 0;
        }

}