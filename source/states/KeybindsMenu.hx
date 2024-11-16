package states;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

using StringTools;

class KeybindsMenu extends MusicBeatState
{
	var songs:Array<String> = [];

	var selector:FlxText;
	public static var curSelected:Int = 0;
	public static var curDifficulty:Int = 1;

	var scoreText:FlxText;
	var diffText:FlxText;
	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var schemArray:Array<String> = ['WASD', 'ZX23', 'DFJK', 'QWOP', 'ASKL'];
	private var checkboxArray:Array<CheckboxThingie> = [];
	private var checkboxNumber:Array<Int> = [];

	public var setBind:Bool = false;
	public var acceptInput:Bool = true;

	var defaultKeys:Array<String> = ["A", "S", "W", "D", "R"];

	var keys:Array<String> = [FlxG.save.data.leftBind,
		FlxG.save.data.downBind,
		FlxG.save.data.upBind,
		FlxG.save.data.rightBind];
	

	override function create()
	{
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic('assets/music/freakyMenu' + TitleState.soundExt);
		}

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		songs.push("LEFT: " + FlxG.save.data.leftBind);

		songs.push("DOWN: " + FlxG.save.data.downBind);

		songs.push("UP: " + FlxG.save.data.upBind);

		songs.push("RIGHT: " + FlxG.save.data.rightBind);

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuBGBlue.png');
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i], false, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpSongs.add(songText);
			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}

		changeSelection();
		changeDiff();

		// FlxG.sound.playMusic('assets/music/title' + TitleState.soundExt, 0);
		// FlxG.sound.music.fadeIn(2, 0, 0.8);
		selector = new FlxText();

		selector.size = 40;
		selector.text = ">";
		// add(selector);

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, 0.4));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (!setBind)
		{
			if (upP)
				{
					changeSelection(-1);
				}
				if (downP)
				{
					changeSelection(1);
				}
		
				if (controls.BACK)
				{
					FlxG.switchState(new OptionsMenu());
				}
		}

		{
			if (FlxG.keys.justPressed.ENTER && !setBind)
				{
					grpSongs.remove(grpSongs.members[curSelected]);
					if (!setBind){
						setBind = true;
					}
				}
				else{
					if (FlxG.keys.justPressed.ANY && !FlxG.keys.justPressed.ENTER && !FlxG.keys.justPressed.ESCAPE && !FlxG.keys.justPressed.SPACE && !FlxG.keys.justPressed.LEFT && !FlxG.keys.justPressed.DOWN && !FlxG.keys.justPressed.UP && !FlxG.keys.justPressed.RIGHT && setBind){
						grpSongs.remove(grpSongs.members[curSelected]);
						switch(curSelected)
						{
							case 0:
								FlxG.save.data.leftBind = FlxG.keys.getIsDown()[0].ID.toString();
								var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "LEFT: " + FlxG.save.data.leftBind, false, false);
								ctrl.isMenuItem = true;
								ctrl.targetY = curSelected - 0;
								grpSongs.add(ctrl);
								setBind = false;
							case 1:
								FlxG.save.data.downBind = FlxG.keys.getIsDown()[0].ID.toString();
								var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "DOWN: " + FlxG.save.data.downBind, false, false);
								ctrl.isMenuItem = true;
								ctrl.targetY = curSelected - 1;
								grpSongs.add(ctrl);
								setBind = false;
							case 2:
								FlxG.save.data.upBind = FlxG.keys.getIsDown()[0].ID.toString();
								var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "UP: " + FlxG.save.data.upBind, false, false);
								ctrl.isMenuItem = true;
								ctrl.targetY = curSelected - 2;
								grpSongs.add(ctrl);
								setBind = false;
							case 3:
								FlxG.save.data.rightBind = FlxG.keys.getIsDown()[0].ID.toString();
								var ctrl:Alphabet = new Alphabet(0, (70 * curSelected) + 30, "RIGHT: " + FlxG.save.data.rightBind, false, false);
								ctrl.isMenuItem = true;
								ctrl.targetY = curSelected - 3;
								grpSongs.add(ctrl);
								setBind = false;
						}
					}
				}
		}
	}

	function changeDiff(change:Int = 0)
	{
	}

	function changeSelection(change:Int = 0)
	{
		// NGio.logEvent('Fresh');
		FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected], curDifficulty);
		// lerpScore = 0;
		#end


		var bullShit:Int = 0;
		for (item in grpSongs.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
