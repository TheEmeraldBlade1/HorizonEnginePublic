package publicVariables;

class Misses {
    public static var misses:Int = 0;

    public static function resetMiss(){
        misses = 0;
    }
    public static function addMiss(){
        misses++;
    }
    public static function returnMiss(){
        return misses;
    }
}