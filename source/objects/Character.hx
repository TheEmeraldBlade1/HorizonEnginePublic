package objects;

import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;

	public var hpIcon:String = "bf";

	var tex:FlxAtlasFrames;

	var charBuild:ForeverModule;
	var exposure:StringMap<Dynamic>;

	public var iconWidth:Int = 150;

	public var healthColorArray:Array<Int> = [255, 0, 0];

	public var updateableScript:Array<ForeverModule> = [];

	var danceRight:Bool = false;
	var packer:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		animOffsets = new Map<String, Array<Dynamic>>();
		super(x, y);

		curCharacter = character;
		this.isPlayer = isPlayer;

		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				getPath('GF_assets');
				
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				healthColorArray = [165, 0, 77];

				hpIcon = "gf";

				iconWidth = 100;

				playAnim('danceRight');

			case 'gf-christmas':
				getPath('gfChristmas');
				
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				hpIcon = "gf";

				healthColorArray = [165, 0, 77];

				iconWidth = 100;

				playAnim('danceRight');

			case 'gf-car':
				getPath('gfCar');
				
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);

					hpIcon = "gf";

					healthColorArray = [165, 0, 77];

					iconWidth = 100;

				playAnim('danceRight');

				case 'gf-tankmen':
					getPath('gfTankmen');
					animation.addByIndices('sad', 'GF Crying at Gunpoint', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, true);
					animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
					animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
	
					playAnim('danceRight');

					healthColorArray = [165, 0, 77];

					iconWidth = 100;

					hpIcon = "gf";

			case 'gf-pixel':
				getPath('gfPixel');
				
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				playAnim('danceRight');

				hpIcon = "gf";

				healthColorArray = [165, 0, 77];

				iconWidth = 100;

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'darnell':
				getPath('DARNELL_WET_FART');
				
				animation.addByPrefix('idle', 'idle', 24);
				animation.addByPrefix('singUP', 'up', 24);
				animation.addByPrefix('singRIGHT', 'left', 24);
				animation.addByPrefix('singDOWN', 'down', 24);
				animation.addByPrefix('singLEFT', 'right', 24);

				hpIcon = "darnell";

				iconWidth = 50;
	
				playAnim('idle');
			case 'spooky':
				getPath('spooky_kids_assets');
				
				animation.addByPrefix('singUP', 'spooky UP NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'spooky DOWN note', 24, false);
				animation.addByPrefix('singLEFT', 'note sing left', 24, false);
				animation.addByPrefix('singRIGHT', 'spooky sing right', 24, false);
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				healthColorArray = [213, 126, 0];

				iconWidth = 100;

				hpIcon = "spooky";

				playAnim('danceRight');

			case 'monster':
				getPath('Monster_Assets');
				
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				hpIcon = "monster";

				healthColorArray = [243, 255, 110];

				playAnim('idle');
			case 'monster-christmas':
				getPath('monsterChristmas');
				
				animation.addByPrefix('idle', 'monster idle', 24, false);
				animation.addByPrefix('singUP', 'monster up note', 24, false);
				animation.addByPrefix('singDOWN', 'monster down', 24, false);
				animation.addByPrefix('singLEFT', 'Monster left note', 24, false);
				animation.addByPrefix('singRIGHT', 'Monster Right note', 24, false);

				hpIcon = "monster";

				healthColorArray = [243, 255, 110];

				playAnim('idle');
			case 'pico':
				getPath('Pico_FNF_assetss');
				
				animation.addByPrefix('idle', "Pico Idle Dance", 24);
				animation.addByPrefix('singUP', 'pico Up note0', 24, false);
				animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
				{
					// Need to be flipped! REDO THIS LATER!
					animation.addByPrefix('singLEFT', 'Pico Note Right0', 24, false);
					animation.addByPrefix('singRIGHT', 'Pico NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'Pico NOTE LEFT miss', 24, false);
					animation.addByPrefix('singLEFTmiss', 'Pico Note Right Miss', 24, false);
				}

				animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
				animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);

				hpIcon = "pico";

				iconWidth = 100;

				healthColorArray = [183, 216, 85];

				playAnim('idle');

				flipX = true;

				case 'pico-player':
					getPath('Pico_FNF_assetss');
					
					animation.addByPrefix('idle', "Pico Idle Dance", 24);
					animation.addByPrefix('singUP', 'pico Up note0', 24, false);
					animation.addByPrefix('singDOWN', 'Pico Down Note0', 24, false);
					{
						animation.addByPrefix('singLEFT', 'Pico NOTE LEFT0', 24, false);
						animation.addByPrefix('singRIGHT', 'Pico Note Right0', 24, false);
						animation.addByPrefix('singRIGHTmiss', 'Pico Note Right Miss', 24, false);
						animation.addByPrefix('singLEFTmiss', 'Pico NOTE LEFT miss', 24, false);
					}
					animation.addByPrefix('singUPmiss', 'pico Up note miss', 24);
					animation.addByPrefix('singDOWNmiss', 'Pico Down Note MISS', 24);
	
					playAnim('idle');

					healthColorArray = [183, 216, 85];

					hpIcon = "pico";

					iconWidth = 100;
	
					flipX = true;

				case 'bf-holding-gf':
					getPath('bfAndGF');
					animation.addByPrefix('idle', 'BF idle dance', 24, false);
					animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
					animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
					animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
					animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
	
					animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
					animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
					animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
					animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
					animation.addByPrefix('bfCatch', 'BF catches GF', 24, false);

					flipX = true;

					healthColorArray = [49, 176, 209];

					hpIcon = "bf-holding-gf";
	
					playAnim('idle');

				case "tankman":
					getPath('tankmanCaptain');
	
					animation.addByPrefix('idle', "Tankman Idle Dance", 24, false);
					animation.addByPrefix('singUP', 'Tankman UP note ', 24, false);
					animation.addByPrefix('singDOWN', 'Tankman DOWN note ', 24, false);
					animation.addByPrefix('singRIGHT', 'Tankman Note Left ', 24, false);
					animation.addByPrefix('singLEFT', 'Tankman Right Note ', 24, false);
	
					animation.addByPrefix('prettyGood', 'PRETTY GOOD', 24, false);
					animation.addByPrefix('ugh', 'TANKMAN UGH', 24, false);

					hpIcon = "tankman";

					healthColorArray = [225, 225, 225];

					iconWidth = 100;
	
					flipX = true;
					playAnim('idle');

					case "tankman-player":
						getPath('tankmanCaptain');
		
						animation.addByPrefix('idle', "Tankman Idle Dance", 24, false);
						animation.addByPrefix('singUP', 'Tankman UP note ', 24, false);
						animation.addByPrefix('singDOWN', 'Tankman DOWN note ', 24, false);
						animation.addByPrefix('singRIGHT', 'Tankman Right Note ', 24, false);
						animation.addByPrefix('singLEFT', 'Tankman Note Left ', 24, false);
		
						animation.addByPrefix('prettyGood', 'PRETTY GOOD', 24, false);
						animation.addByPrefix('ugh', 'TANKMAN UGH', 24, false);
	
						healthColorArray = [225, 225, 225];

						iconWidth = 100;

						hpIcon = "tankman";
		
						flipX = true;
						playAnim('idle');

			case 'bf-christmas':
				getPath('bfChristmas');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				playAnim('idle');

				hpIcon = "bf";

				healthColorArray = [49, 176, 209];

				flipX = true;
			case 'bf-car':
				getPath('bfCar');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);

				playAnim('idle');

				hpIcon = "bf";

				healthColorArray = [49, 176, 209];

				flipX = true;
			case 'bf-pixel':
				getPath('bfPixel');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				width -= 100;
				height -= 100;

				iconWidth = 100;

				hpIcon = "bf-pixel";

				healthColorArray = [123, 214, 246];

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				getPath('bfPixelsDEAD');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				animation.play('firstDeath');

				playAnim('firstDeath');

				hpIcon = "bf-pixel";

				iconWidth = 100;

				healthColorArray = [123, 214, 246];

				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'senpai':
				getPath('senpai');
				animation.addByPrefix('idle', 'Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'SENPAI UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'SENPAI LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'SENPAI RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'SENPAI DOWN NOTE', 24, false);

				playAnim('idle');

				hpIcon = "senpai";

				healthColorArray = [255, 170, 111];

				iconWidth = 100;

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				getPath('senpai');
				animation.addByPrefix('idle', 'Angry Senpai Idle', 24, false);
				animation.addByPrefix('singUP', 'Angry Senpai UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'Angry Senpai LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'Angry Senpai RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'Angry Senpai DOWN NOTE', 24, false);

				playAnim('idle');

				hpIcon = "senpai";

				iconWidth = 100;

				healthColorArray = [255, 170, 111];

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				getPacker('spirit');
				animation.addByPrefix('idle', "idle spirit_", 24, false);
				animation.addByPrefix('singUP', "up_", 24, false);
				animation.addByPrefix('singRIGHT', "right_", 24, false);
				animation.addByPrefix('singLEFT', "left_", 24, false);
				animation.addByPrefix('singDOWN', "spirit down_", 24, false);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				iconWidth = 50;

				healthColorArray = [255, 60, 110];

				hpIcon = "spirit";

				antialiasing = false;

			case 'parents-christmas':
				getPath('mom_dad_christmas_assets');
				animation.addByPrefix('idle', 'Parent Christmas Idle', 24, false);
				animation.addByPrefix('singUP', 'Parent Up Note Dad', 24, false);
				animation.addByPrefix('singDOWN', 'Parent Down Note Dad', 24, false);
				animation.addByPrefix('singLEFT', 'Parent Left Note Dad', 24, false);
				animation.addByPrefix('singRIGHT', 'Parent Right Note Dad', 24, false);

				animation.addByPrefix('singUP-alt', 'Parent Up Note Mom', 24, false);

				animation.addByPrefix('singDOWN-alt', 'Parent Down Note Mom', 24, false);
				animation.addByPrefix('singLEFT-alt', 'Parent Left Note Mom', 24, false);
				animation.addByPrefix('singRIGHT-alt', 'Parent Right Note Mom', 24, false);

				hpIcon = "parents-christmas";

				healthColorArray = [175, 102 + 85, 142];

				playAnim('idle');

				default:
					exposure = new StringMap<Dynamic>();
					exposure.set('addAnimation', addAnimation);
					exposure.set('getPath', getPath);
					exposure.set('getHPIcon', getHPIcon);
					exposure.set('isPlayer', isPlayer);
					exposure.set('getIconColorArray', getIconColorArray);
					exposure.set('getIconWidth', getIconWidth);
					exposure.set('playAnim', playAnim);
					exposure.set('getFlipX', getFlipX);
					exposure.set('updateHitbox', updateHitbox);
					exposure.set('setGraphicSize', setGraphicSize);
					exposure.set('height', height);
					exposure.set('width', width);
					charBuild = ScriptHandler.loadModule('backend/characters/' + curCharacter + '.hxs', exposure);
					updateableScript.push(charBuild);

					if (charBuild.exists("createCharacter"))
						charBuild.get("createCharacter")();
				
		}


		loadOffsetFile(curCharacter);

		dance();

		if (isPlayer)
		{
			flipX = !flipX;

			/*// Doesn't flip for BF, since his are already in the right place???
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').oldMiss;
				}
			}*/
		}
	}

	public function getFlipX(bool:Bool = false){
		flipX = bool;
	}

	public function getHPIcon(string:String = 'bf'){
		hpIcon = string;
	}

	public function getIconColorArray(int1:Int = 255, int2:Int = 0, int3:Int = 0){
		healthColorArray = [int1, int2, int3];
	}

	public function getIconWidth(int:Int = 150){
		iconWidth = int;
	}

	public function addAnimation(name:String = 'idle', xmlPath:String = 'idle', fps:Int = 24, loop:Bool = false){
		this.animation.addByPrefix(name, xmlPath, fps, loop);
	}

	public function getPath(path:String)
	{
		frames = FlxAtlasFrames.fromSparrow('assets/characters/' + path + '.png', 'assets/characters/' + path + '.xml');
		trace('LOADED: ' + path);
	}

	public function getPacker(path:String)
		{
			frames = FlxAtlasFrames.fromSpriteSheetPacker('assets/characters/' + path + '.png', 'assets/characters/' + path + '.txt');
			trace('LOADED: ' + path);
		}

	public function loadOffsetFile(character:String)
		{
			var offset:Array<String> = CoolUtil.coolTextFile('assets/characters/offsets/' + character + "Offsets.fnfchar");
	
			for (i in 0...offset.length)
			{
				var data:Array<String> = offset[i].split(' ');
				addOffset(data[0], Std.parseInt(data[1]), Std.parseInt(data[2]));
			}
		}

	override function update(elapsed:Float)
	{
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf-tankmen':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-christmas':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'gf-car':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}
				case 'gf-pixel':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(animation.curAnim.name);
		if (animOffsets.exists(animation.curAnim.name))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
