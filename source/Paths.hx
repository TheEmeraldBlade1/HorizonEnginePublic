package;

import flixel.graphics.frames.FlxAtlasFrames;

class Paths 
{
    
public static function getSparrowAtlas(path:String)
{
    return FlxAtlasFrames.fromSparrow('assets/images/' + path + '.png', 'assets/images/' + path + '.xml');
    trace('LOADED: ' + path);
}

}