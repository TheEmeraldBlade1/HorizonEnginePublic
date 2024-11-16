package objects;

class Cursor {
    public static function createCursor(){
        FlxG.mouse.visible = true;
        FlxG.mouse.unload();
        if (FlxG.save.data.systemCursor){
            FlxG.mouse.useSystemCursor = true;
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.log.add("Sexy mouse cursor " + "assets/cursor/cursor-default.png");
            FlxG.mouse.load("assets/cursor/cursor-default.png");
        }
    }
    public static function createCursorPointer(){
        FlxG.mouse.visible = true;
        FlxG.mouse.unload();
        if (FlxG.save.data.systemCursor){
            FlxG.mouse.useSystemCursor = true;
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.log.add("assets/cursor/cursor-pointer.png");
            FlxG.mouse.load("assets/cursor/cursor-pointer.png");
        }
    }
    public static function createCursorCell(){
        FlxG.mouse.visible = true;
        FlxG.mouse.unload();
        if (FlxG.save.data.systemCursor){
            FlxG.mouse.useSystemCursor = true;
        }else{
            FlxG.mouse.useSystemCursor = false;
            FlxG.log.add("Sexy mouse cursor " + "assets/cursor/cursor-cell.png");
            FlxG.mouse.load("assets/cursor/cursor-cell.png");
        }
    }
    public static function unloadCursor()
    {
        FlxG.mouse.visible = false;
        FlxG.mouse.unload(); 
    }
    public static function toggleCursor()
    {
        FlxG.mouse.visible = !FlxG.mouse.visible;
    }
}