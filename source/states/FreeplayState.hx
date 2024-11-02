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
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;

using StringTools;

class FreeplayState extends MusicBeatState
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

	var difficultySelectors:FlxGroup;
	var sprDifficulty:FlxSprite;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;
	
	var DJ1:FlxSprite;
	var DJ2:FlxSprite;

	var daTime:Float = 0.9;

	var erectSongs:Array<String> = ['Dadbattle', 'Blammed', 'Fresh', 'Bopeebo', 'Thorns', 'Senpai', 'Roses'];

	override function create()
	{
		//if (!FlxG.sound.music.playing)
		{
			FlxG.sound.music.stop();
			FlxG.sound.playMusic('assets/music/freeplayRandom' + TitleState.soundExt);
		}

		var isDebug:Bool = false;

		#if debug
		isDebug = true;
		#end

		if (StoryMenuState.weekUnlocked[0] || isDebug)
		{
			songs.push('Tutorial');
		}

		if (StoryMenuState.weekUnlocked[1] || isDebug)
		{
			songs.push('Bopeebo');
			songs.push('Fresh');
			songs.push('Dadbattle');
		}

		if (StoryMenuState.weekUnlocked[2] || isDebug)
		{
			songs.push('Spookeez');
			songs.push('South');
		}

		if (StoryMenuState.weekUnlocked[3] || isDebug)
		{
			songs.push('Pico');
			songs.push('Philly');
			songs.push('Blammed');
		}

		if (StoryMenuState.weekUnlocked[4] || isDebug)
		{
			songs.push('Satin-Panties');
			songs.push('High');
			songs.push('Milf');
		}

		if (StoryMenuState.weekUnlocked[5] || isDebug)
		{
			songs.push('Cocoa');
			songs.push('Eggnog');
			songs.push('Winter-Horrorland');
		}

		if (StoryMenuState.weekUnlocked[6] || isDebug)
		{
			songs.push('Senpai');
			songs.push('Roses');
			songs.push('Thorns');
		}

		if (StoryMenuState.weekUnlocked[7] || isDebug)
		{
			songs.push('Ugh');
			songs.push('Guns');
			songs.push('Stress');
		}

		/*if (StoryMenuState.weekUnlocked[100] || isDebug)
		{
			songs.push('Darnell');
			songs.push('Lit-Up');
			songs.push('2hot');
			songs.push('Blazin');
		}*/

		// LOAD MUSIC

		// LOAD CHARACTERS

		var bg:FlxSprite = new FlxSprite().loadGraphic('assets/images/freeplay/freeplayBGdad.png');
		add(bg);

		DJ1 = new FlxSprite(870, 350);
		DJ1.frames = FlxAtlasFrames.fromSparrow('assets/images/freeplay/DJ.png', 'assets/images/freeplay/DJ.xml');
		DJ1.animation.addByPrefix('DJ IDLE', "Boyfriend DJ0", 24);
		DJ1.animation.addByPrefix('DJ CONFIRM', "Boyfriend DJ confirm", 24);
		DJ1.animation.play('DJ IDLE');
		DJ1.scrollFactor.set(0.4, 0.4);
		DJ1.antialiasing = true;

		DJ2 = new FlxSprite(20, 350);
		DJ2.frames = FlxAtlasFrames.fromSparrow('assets/images/freeplay/DJ2.png', 'assets/images/freeplay/DJ2.xml');
		DJ2.animation.addByPrefix('DJ IDLE', "Pico DJ0", 24);
		DJ2.animation.addByPrefix('DJ CONFIRM', "Pico DJ confirm0", 24);
		DJ2.animation.play('DJ IDLE');
		DJ2.scrollFactor.set(0.4, 0.4);
		DJ2.antialiasing = true;

		add(DJ1);
		add(DJ2);

		grpSongs = new FlxTypedGroup<Alphabet>();
		add(grpSongs);

		for (i in 0...songs.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, songs[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			songText.itemType = 'Center';
			grpSongs.add(songText);
			// songText.x += 40;
			// DONT PUT X IN THE FIRST PARAMETER OF new ALPHABET() !!
			// songText.screenCenter(X);
		}
		

		scoreText = new FlxText(FlxG.width * 0.7, 5, 0, "", 32);
		scoreText.screenCenter(X);
		scoreText.x -= 200;
		// scoreText.autoSize = false;
		scoreText.setFormat("assets/fonts/vcr.ttf", 32, FlxColor.WHITE, RIGHT);
		// scoreText.alignment = RIGHT;

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		var ui_tex = FlxAtlasFrames.fromSparrow('assets/images/freeplay/freeplay_pointer.png', 'assets/images/freeplay/freeplay_pointer.xml');

		trace("Line 124");

		leftArrow = new FlxSprite(0, 0 + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow pointer loop");
		leftArrow.animation.addByPrefix('press', "arrow pointer prssed");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		var ui_diff = FlxAtlasFrames.fromSparrow('assets/images/freeplay/diffs/$curDifficulty.png', 'assets/images/freeplay/diffs/$curDifficulty.xml');
		sprDifficulty = new FlxSprite(leftArrow.x + 130, leftArrow.y);
		sprDifficulty.frames = ui_diff;
		sprDifficulty.animation.addByPrefix('idle', 'diff0');
		sprDifficulty.animation.play('idle');
		changeDiff();

		difficultySelectors.add(sprDifficulty);

		rightArrow = new FlxSprite(sprDifficulty.x + 180, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow pointer loop');
		rightArrow.animation.addByPrefix('press', "arrow pointer prssed", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.flipX = true;
		difficultySelectors.add(rightArrow);


		var scoreBG:FlxSprite = new FlxSprite(scoreText.x - 6, 0).makeGraphic(Std.int(FlxG.width * 0.35), 66, 0xFF000000);
		scoreBG.alpha = 0.6;
		add(scoreBG);

		diffText = new FlxText(scoreText.x + 150, scoreText.y + 36, 0, "", 24);
		diffText.font = scoreText.font;
		add(diffText);

		add(scoreText);

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

		var ui_diff = FlxAtlasFrames.fromSparrow('assets/images/freeplay/diffs/$curDifficulty.png', 'assets/images/freeplay/diffs/$curDifficulty.xml');
		sprDifficulty.frames = ui_diff;

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;

		scoreText.text = "PERSONAL BEST:" + lerpScore;

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

		if (controls.RIGHT)
			rightArrow.animation.play('press')
		else
			rightArrow.animation.play('idle');

		if (controls.LEFT)
			leftArrow.animation.play('press');
		else
			leftArrow.animation.play('idle');

		if (controls.LEFT_P)
			changeDiff(-1);
		if (controls.RIGHT_P)
			changeDiff(1);

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			FlxG.sound.play('assets/sounds/cancelMenu' + TitleState.soundExt);
			FlxG.switchState(new MainMenuState());
		}
		if (accepted)
		{
			DJ1.animation.play('DJ CONFIRM');
			DJ2.animation.play('DJ CONFIRM');
			FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);
			for (i in 0...grpSongs.members.length)
				{
					if (i == curSelected)
					{
						FlxFlicker.flicker(grpSongs.members[i], 1, 0.06, false, false);
					}
				}
		
				new FlxTimer().start(daTime, function(tmr:FlxTimer)
				{
					var poop:String = Highscore.formatSong(songs[curSelected].toLowerCase(), curDifficulty);

					trace(poop);
		
					PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].toLowerCase());
					PlayState.isStoryMode = false;
					PlayState.storyDifficulty = curDifficulty;
					FlxG.switchState(new PlayState());
					if (FlxG.sound.music != null)
						FlxG.sound.music.stop();
				});
		}
	}

	function changeDiff(change:Int = 0)
	{
		curDifficulty += change;

		if (erectSongs.contains(songs[curSelected]))
		{
			if (curDifficulty < 0)
				curDifficulty = 4;
			if (curDifficulty > 4)
				curDifficulty = 0;
		}else{
			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;
		}

		sprDifficulty.offset.x = 0;

		switch (curDifficulty)
		{
			case 0:
				sprDifficulty.animation.play('idle');
				sprDifficulty.offset.x = 60;
				sprDifficulty.offset.y = -10;
			case 1:
				sprDifficulty.animation.play('idle');
				sprDifficulty.offset.x = 60;
				sprDifficulty.offset.y = -10;
			case 2:
				sprDifficulty.animation.play('idle');
				sprDifficulty.offset.x = 60;
				sprDifficulty.offset.y = -10;
			case 3:
				sprDifficulty.animation.play('idle');
				sprDifficulty.offset.x = 70;
				sprDifficulty.offset.y = -10;
			case 4:
				sprDifficulty.animation.play('idle');
				sprDifficulty.offset.x = 60;
				sprDifficulty.offset.y = -10;
			case 5:
				sprDifficulty.animation.play('idle');
				sprDifficulty.offset.x = 60;
				sprDifficulty.offset.y = -10;
		}

		sprDifficulty.alpha = 0;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected], curDifficulty);
		#end

		FlxTween.tween(sprDifficulty, {alpha: 1}, 0.07);
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

		changeDiff();

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
