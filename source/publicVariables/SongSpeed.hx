package publicVariables;

class SongSpeed {
    public static function returnSongSpeed()
    {
        return FlxG.save.data.song_speed;
    }
}