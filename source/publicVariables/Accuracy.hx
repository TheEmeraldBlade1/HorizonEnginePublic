package publicVariables;

class Accuracy {
    public static var accuracy:Float = 0.00;
    public static var totalNotesHit:Float = 0;
	public static var totalPlayed:Int = 0;
    public static var ratingString:String = "?";
    public static var ratingStuff:Array<Dynamic> = [
		['You Suck!', 19], //From 0% to 19%
		['Shit',39], //From 20% to 39%
		['Bad', 49], //From 40% to 49%
		['Bruh', 59], //From 50% to 59%
		['Meh', 68], //From 60% to 68%
		['Nice', 69], //69%
		['Good', 79], //From 70% to 79%
		['Great', 89], //From 80% to 89%
		['Sick!', 99], //From 90% to 99%
		['Perfect!!', 100] //The value on this one isn't used actually, since Perfect is always "1"
	];

    public static function resetAcurracy(){
        accuracy = 0.00;
        totalPlayed = 0;
        totalNotesHit = 0;
        ratingString = "?";
    }

    public static function addTotalNotesHit(){
        totalNotesHit += 1;
    }

    public static function retrunAccuray(decimals:Int){
        return CoolUtil.truncateFloat(accuracy, decimals);
    }

    public static function returnRating(){
        return ratingString;
    }
    
    public static function ratingAcurracyGet(daRating:String):Void {
        switch(daRating) {
            case 'sick': totalNotesHit += 1;
            case 'good': totalNotesHit += 0.65;
            case 'bad': totalNotesHit += 0.2;
            case 'shit': totalNotesHit -= 2;
        }
    }

    public static function updateAccuracy()
	{
		totalPlayed += 1;
		accuracy = totalNotesHit / totalPlayed * 100;
		//trace(totalNotesHit + '/' + totalPlayed + '* 100 = ' + accuracy);
		if (accuracy >= 100.00)
		{
				accuracy = 100;
				ratingString = ratingStuff[ratingStuff.length-1][0]; //Uses last string
		}
		else
		{
			for (i in 0...ratingStuff.length-1) {
				if(accuracy < ratingStuff[i][1]) {
					ratingString = ratingStuff[i][0];
					break;
				}
			}
		}
		
	}
}