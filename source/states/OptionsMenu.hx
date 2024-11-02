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

class OptionsMenu extends MusicBeatState
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

		songs.push('Ghost Tapping');

		songs.push('Keybinds');

		songs.push('Downscroll');

		songs.push('Accuracy Counter');

		songs.push('Flip Note X');

		songs.push('Flip Note Y');

		songs.push('Centered Strumline');

		songs.push('Note Colors');

		songs.push('Quant Notes');
		
		songs.push('Song Length');

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/menuBGBlue.png');
		add(bg);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			songText.itemType = 'Center';
			grpSongs.add(songText);
			if (i != 1 && i != 7){
				var checkbox:CheckboxThingie = new CheckboxThingie(songText.x, songText.y, false);
				checkbox.sprTracker = songText;
				checkboxArray.push(checkbox);
				checkboxNumber.push(i);
				add(checkbox);
			}
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
			FlxG.switchState(new MainMenuState());
		}

		for (i in 0...checkboxArray.length)
		{
			var checkbox:CheckboxThingie = checkboxArray[i];
			switch (songs[checkboxNumber[i]])
			{
				case 'Ghost Tapping':
					checkbox.daValue = FlxG.save.data.gt;
				case 'Downscroll':
					checkbox.daValue = FlxG.save.data.DownScroll;
				case 'Accuracy Counter':
					checkbox.daValue = FlxG.save.data.accuracyCounter;
				case 'Flip Note X':
					checkbox.daValue = FlxG.save.data.NoteFlipX;
				case 'Flip Note Y':
					checkbox.daValue = FlxG.save.data.NoteFlipY;
				case 'Middlescroll':
					checkbox.daValue = FlxG.save.data.getMiddleScroll;
				case 'Quant Notes':
					checkbox.daValue = FlxG.save.data.stepMania;
				case 'Song Length':
					checkbox.daValue = FlxG.save.data.timeBarTxt;
			}
		}

		if (accepted)
		{
			switch (curSelected)
			{
				case 0:
					FlxG.save.data.gt = !FlxG.save.data.gt;

				case 1:
					FlxG.switchState(new KeybindsMenu());
				case 2:
					FlxG.save.data.DownScroll = !FlxG.save.data.DownScroll;
				case 3:
					FlxG.save.data.accuracyCounter = !FlxG.save.data.accuracyCounter;
				case 4:
					FlxG.save.data.NoteFlipX = !FlxG.save.data.NoteFlipX;
				case 5:
					FlxG.save.data.NoteFlipY = !FlxG.save.data.NoteFlipY;
				case 6:
					FlxG.save.data.getMiddleScroll = !FlxG.save.data.getMiddleScroll;
				case 7:
					FlxG.switchState(new NoteColorsState());
				case 8:
					FlxG.save.data.stepMania = !FlxG.save.data.stepMania;
				case 9:
					FlxG.save.data.timeBarTxt = !FlxG.save.data.timeBarTxt;
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
