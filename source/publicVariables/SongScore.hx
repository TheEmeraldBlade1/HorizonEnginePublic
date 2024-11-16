package publicVariables;

class SongScore { 
    public static var songScore:Int = 0;

    public static function resetScore():Void {
        songScore = 0;
    }

    public static function scoreAdd(points:Int = 1):Void {
        songScore += points;
    }

    public static function removeScore(points:Int = 100):Void {
        songScore -= points;
    }

    public static function ratingScoreGet(daRating:String):Void {
        switch(daRating) {
            case 'epic': songScore += 700;
            case 'sick': songScore += 350;
            case 'good': songScore += 200;
            case 'bad': songScore += 100;
            case 'shit': songScore += 50;
        }
    }

    public static function returnScore():Int {
        return songScore;
    }
}
