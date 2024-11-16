package substates;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.system.FlxSound;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<String> = ['Resume', 'Restart Song', 'Toggle Ghost Tapping', 'Exit to menu'];
	var curSelected:Int = 0;

	var options:FlxText;

	var pauseMusic:FlxSound;

	public var instance:MainMenuState;

	var startTimer:FlxTimer;

	public var stopInput:Bool = false;

	public function new(x:Float, y:Float)
	{
		super();

		pauseMusic = new FlxSound().loadEmbedded('assets/music/breakfast' + TitleState.soundExt, true, true);
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0.6;
		bg.scrollFactor.set();
		add(bg);

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat("assets/fonts/vcr.ttf", 32);
		levelInfo.updateHitbox();

		options = new FlxText(20, 15, 0, "", 32);
		options.scrollFactor.set();
		options.setFormat("assets/fonts/vcr.ttf", 32);
		options.updateHitbox();
		options.visible = false;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		options.x = FlxG.width - (options.width + 520);
		options.screenCenter(X);
		options.x -= 150;

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			songText.itemType = 'Center';
			grpMenuShit.add(songText);
		}

		add(levelInfo);
		add(options);

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		if (pauseMusic.volume < 0.5)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (!stopInput){
			if (upP)
				{
					changeSelection(-1);
				}
				if (downP)
				{
					changeSelection(1);
				}
		}

		switch (curSelected){
			case 2:
				options.visible = true;
				options.text = "Ghost Tapping: " + FlxG.save.data.gt;
			default:
				options.visible = false;
		}

		if (!stopInput){
			if (accepted)
				{
					var daSelected:String = menuItems[curSelected];
		
					switch (daSelected)
					{
						case "Resume":
							stopInput = true;
							startCountdown();
						case "Restart Song":
							FlxG.resetState();
						case 'Toggle Ghost Tapping':
							FlxG.save.data.gt = !FlxG.save.data.gt;
						case "Exit to menu":
							ChartingMode.charting_Mode = false;
							if (PlayState.isStoryMode)
								FlxG.switchState(new StoryMenuState());
							else
								FlxG.switchState(new FreeplayState());
					}
				}
		}
		
		if (!stopInput){
			if (FlxG.keys.justPressed.ESCAPE)
				{
					stopInput = true;
					startCountdown();
				}
		}

		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}
	}

	override function destroy()
	{
		pauseMusic.destroy();

		super.destroy();
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
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

	function startCountdown():Void
		{
			var swagCounter:Int = 0;
	
			startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
			{
				var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
				introAssets.set('default', ['ready.png', "set.png", "go.png"]);
				introAssets.set('school', [
					'weeb/pixelUI/ready-pixel.png',
					'weeb/pixelUI/set-pixel.png',
					'weeb/pixelUI/date-pixel.png'
				]);
				var introAlts:Array<String> = introAssets.get('default');
				var altSuffix:String = "";
	
				switch (swagCounter)
	
				{
					case 0:
						FlxG.sound.play('assets/sounds/intro3' + altSuffix + TitleState.soundExt, 0.6);
					case 1:
						var ready:FlxSprite = new FlxSprite().loadGraphic('assets/images/' + introAlts[0]);
						ready.scrollFactor.set();
						ready.updateHitbox();
	
						ready.screenCenter();
						add(ready);
						FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								ready.destroy();
							}
						});
						FlxG.sound.play('assets/sounds/intro2' + altSuffix + TitleState.soundExt, 0.6);
					case 2:
						var set:FlxSprite = new FlxSprite().loadGraphic('assets/images/' + introAlts[1]);
						set.scrollFactor.set();
						set.screenCenter();
						add(set);
						FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								set.destroy();
							}
						});
						FlxG.sound.play('assets/sounds/intro1' + altSuffix + TitleState.soundExt, 0.6);
					case 3:
						var go:FlxSprite = new FlxSprite().loadGraphic('assets/images/' + introAlts[2]);
						go.scrollFactor.set();
	
						go.updateHitbox();
	
						go.screenCenter();
						add(go);
						FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
							ease: FlxEase.cubeInOut,
							onComplete: function(twn:FlxTween)
							{
								go.destroy();
							}
						});
						FlxG.sound.play('assets/sounds/introGo' + altSuffix + TitleState.soundExt, 0.6);
					case 4:
						close();
				}
	
				swagCounter += 1;
				// generateSong('fresh');
			}, 5);
		}
}
