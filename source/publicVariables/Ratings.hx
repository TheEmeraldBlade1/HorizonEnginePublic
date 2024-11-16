package publicVariables;

class Ratings {
    public static var epics:Int = 0;
    public static var sicks:Int = 0;
    public static var goods:Int = 0;
    public static var bads:Int = 0;
    public static var shits:Int = 0;

    public static function resetRatings()
    {
        epics = 0;
        sicks = 0;
        goods = 0;
        bads = 0;
        shits = 0;
    }

    public static function addEpics()
    {
        epics++;
    }

    public static function addSicks()
    {
        sicks++;
    }

    public static function addGoods()
    {
        goods++;
    }

    public static function addBads()
    {
        bads++;
    }

    public static function addShits()
    {
        shits++;
    }

    public static function returnEpics()
    {
        return epics;
    }
        
    public static function returnSicks()
    {
        return sicks;
    }
    
    public static function returnGoods()
    {
        return goods;
    }
    
    public static function returnBads()
    {
        return bads;
    }
    
    public static function returnShits()
    {
        return shits;
    }
}