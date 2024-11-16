package states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.ui.FlxButton;

/**
	*DEBUG MODE
 */
 using StringTools;
class AnimationDebug extends FlxState
{
	var _file:FileReference;
	var bf:Boyfriend;
	var dad:Character;
	var dadBG:Character;
	var char:Character;
	var textAnim:FlxText;
	var dumbTexts:FlxTypedGroup<FlxText>;
	var animList:Array<String> = [];
	var curAnim:Int = 0;
	var isDad:Bool = true;
	var daAnim:String = 'spooky';
	var camFollow:FlxObject;
	public static var menu:Bool = false;
	var UI_box:FlxUITabMenu;
	var UI_options:FlxUITabMenu;
	var offsetX:FlxUINumericStepper;
	var offsetY:FlxUINumericStepper;

	var characters:Array<String>;

	public function new(daAnim:String = 'spooky')
	{
		super();
		this.daAnim = daAnim;
	}

	override function create()
	{
		FlxG.sound.music.stop();

		Cursor.createCursor();

		FlxG.mouse.visible = true;

		var gridBG:FlxSprite = FlxGridOverlay.create(10, 10);
		gridBG.scrollFactor.set(0.5, 0.5);
		gridBG.scale.x = 10;
		gridBG.scale.y = 10;
		add(gridBG);


		if (isDad)
		{
			dad = new Character(0, 0, daAnim);
			dad.screenCenter();
			dad.debugMode = true;

			dadBG = new Character(0, 0, daAnim);
			dadBG.screenCenter();
			dadBG.debugMode = true;
			dadBG.flipX = false;
			dadBG.alpha = 0.75;
			dadBG.color = 0xFF000000;
	
			add(dadBG);
			add(dad);

			char = dad;
			dad.flipX = false;
		}
		else
		{
			bf = new Boyfriend(0, 0);
			bf.screenCenter();
			bf.debugMode = true;
			add(bf);

			char = bf;
			bf.flipX = false;
		}

		dumbTexts = new FlxTypedGroup<FlxText>();
		add(dumbTexts);

		textAnim = new FlxText(300, 16);
		textAnim.size = 26;
		textAnim.scrollFactor.set();
		add(textAnim);

		genBoyOffsets();

		characters = CoolUtil.coolTextFile('assets/data/charlist.fnflist');

		var tabs = [{name: "Offsets", label: 'Offset menu'},];

		UI_box = new FlxUITabMenu(null, tabs, true);

		UI_box.scrollFactor.set();
		UI_box.resize(150, 200);
		UI_box.x = FlxG.width - UI_box.width - 20;
		UI_box.y = 20;

		// var opt_tabs = [{name: "test", label: 'test'}];

		// UI_options = new FlxUITabMenu(null, opt_tabs, true);

		// UI_options.scrollFactor.set();
		// UI_options.selected_tab = 0;
		// UI_options.resize(300, 200);
		// UI_options.x = UI_box.x;
		// UI_options.y = FlxG.height - 300;
		// no need for now
		// add(UI_options);
		add(UI_box);

		addOffsetUI();

		camFollow = new FlxObject(0, 0, 2, 2);
		camFollow.screenCenter();
		add(camFollow);

		FlxG.camera.follow(camFollow);

		super.create();
	}

	function addOffsetUI():Void
		{
			var player1DropDown = new FlxUIDropDownMenu(10, 10, FlxUIDropDownMenu.makeStrIdLabelArray(characters, true), function(character:String)
			{
				remove(dadBG);
				remove(dad);
				dad = new Character(0, 0, characters[Std.parseInt(character)]);
				dad.screenCenter();
				dad.debugMode = true;
				dad.flipX = false;
				dadBG = new Character(0, 0, characters[Std.parseInt(character)]);
				dadBG.screenCenter();
				dadBG.debugMode = true;
				dadBG.flipX = false;
				dadBG.alpha = 0.75;
				dadBG.color = 0xFF000000;
				add(dadBG);
				add(dad);
	
				replace(char, dad);
				char = dad;
	
				dumbTexts.clear();
				genBoyOffsets(true, true);
				updateTexts();
			});
	
			player1DropDown.selectedLabel = char.curCharacter;

			var saveButton:FlxButton = new FlxButton(-100, 10, "Save", function()
			{
				saveBoyOffsets();
			});

			var tab_group_offsets = new FlxUI(null, UI_box);
			tab_group_offsets.name = "Offsets";

			tab_group_offsets.add(player1DropDown);
			tab_group_offsets.add(saveButton);
	
			UI_box.addGroup(tab_group_offsets);
		}

		function genBoyOffsets(pushList:Bool = true, ?cleanArray:Bool = false):Void
			{
				if (cleanArray)
					animList.splice(0, animList.length);
		
				var daLoop:Int = 0;
		
				for (anim => offsets in char.animOffsets)
				{
					var text:FlxText = new FlxText(10, 20 + (18 * daLoop), 0, anim + ": " + offsets, 15);
					text.scrollFactor.set();
					text.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
					text.color = FlxColor.WHITE;
					dumbTexts.add(text);
		
					if (pushList)
						animList.push(anim);
		
					daLoop++;
				}
			}

	function updateTexts():Void
	{
		dumbTexts.forEach(function(text:FlxText)
		{
			text.kill();
			dumbTexts.remove(text, true);
		});
	}

	function saveBoyOffsets():Void
		{
			var result = "";
	
			for (anim => offsets in char.animOffsets)
			{
				var text = anim + " " + offsets.join(" ");
				result += text + "\n";
			}
	
			if ((result != null) && (result.length > 0))
			{
				_file = new FileReference();
				_file.addEventListener(Event.COMPLETE, onSaveComplete);
				_file.addEventListener(Event.CANCEL, onSaveCancel);
				_file.addEventListener(IOErrorEvent.IO_ERROR, onSaveError);
				_file.save(result.trim(), daAnim + "Offsets.fnfchar");
			}
		}
	
		/**
		 * Called when the save file dialog is completed.
		 */
		function onSaveComplete(_):Void
		{
			_file.removeEventListener(Event.COMPLETE, onSaveComplete);
			_file.removeEventListener(Event.CANCEL, onSaveCancel);
			_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file = null;
			FlxG.log.notice("Successfully saved OFFSET DATA.");
		}
	
		/**
		 * Called when the save file dialog is cancelled.
		 */
		function onSaveCancel(_):Void
		{
			_file.removeEventListener(Event.COMPLETE, onSaveComplete);
			_file.removeEventListener(Event.CANCEL, onSaveCancel);
			_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file = null;
		}
	
		/**
		 * Called if there is an error while saving the offset data.
		 */
		function onSaveError(_):Void
		{
			_file.removeEventListener(Event.COMPLETE, onSaveComplete);
			_file.removeEventListener(Event.CANCEL, onSaveCancel);
			_file.removeEventListener(IOErrorEvent.IO_ERROR, onSaveError);
			_file = null;
			FlxG.log.error("Problem saving Offset data");
		}

	override function update(elapsed:Float)
	{
		textAnim.text = char.animation.curAnim.name;

		if (FlxG.mouse.overlaps(char) && FlxG.mouse.pressed)
			{
				// HOW THE FUCK DO I CONVERT THIS
				char.animOffsets.get(animList[curAnim])[0] = -Math.round(FlxG.mouse.x - char.frameWidth * 1.5);
				char.animOffsets.get(animList[curAnim])[1] = -Math.round(FlxG.mouse.y - char.frameHeight / 2);
	
				updateTexts();
				genBoyOffsets(false);
				char.playAnim(animList[curAnim]);
				// TO MOUSE MOVEMENT?????????
			}

			updateTexts();
			genBoyOffsets(false);

		if (FlxG.mouse.wheel != 0)
			FlxG.camera.zoom += 0.1 * FlxG.mouse.wheel;

		if (FlxG.keys.pressed.I || FlxG.keys.pressed.J || FlxG.keys.pressed.K || FlxG.keys.pressed.L)
		{
			if (FlxG.keys.pressed.I)
				camFollow.velocity.y = -190;
			else if (FlxG.keys.pressed.K)
				camFollow.velocity.y = 190;
			else
				camFollow.velocity.y = 0;

			if (FlxG.keys.pressed.J)
				camFollow.velocity.x = -190;
			else if (FlxG.keys.pressed.L)
				camFollow.velocity.x = 190;
			else
				camFollow.velocity.x = 0;
		}
		else
		{
			camFollow.velocity.set();
		}

		if (FlxG.keys.justPressed.W)
		{
			char.playAnim('singUP');
		}

		if (FlxG.keys.justPressed.S)
		{
			char.playAnim('singDOWN');
		}

		if (FlxG.keys.justPressed.A)
		{
			char.playAnim('singLEFT');
		}

		if (FlxG.keys.justPressed.D)
		{
			char.playAnim('singRIGHT');
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			char.playAnim('idle');
		}


		if (FlxG.keys.justPressed.F)
		{
			char.flipX = !char.flipX;
			dadBG.flipX = !dadBG.flipX;
		}

		if (FlxG.keys.justPressed.Q)
			{
				curAnim -= 1;
				updateTexts();
				genBoyOffsets(false);
				char.playAnim(animList[curAnim]);
			}
		
			if (FlxG.keys.justPressed.E)
			{
				curAnim += 1;
				updateTexts();
				genBoyOffsets(false);
				char.playAnim(animList[curAnim]);

			}

		if (curAnim < 0)
			curAnim = animList.length - 1;

		if (curAnim >= animList.length)
			curAnim = 0;

		if (FlxG.keys.justPressed.ESCAPE)
			{
				FlxG.mouse.visible = false;
				if (menu)
				{
					FlxG.switchState(new DebugMenu());
				}
				else
				{
					FlxG.switchState(new PlayState());
				}
			}

		var upP = FlxG.keys.anyJustPressed([UP]);
		var rightP = FlxG.keys.anyJustPressed([RIGHT]);
		var downP = FlxG.keys.anyJustPressed([DOWN]);
		var leftP = FlxG.keys.anyJustPressed([LEFT]);

		var holdShift = FlxG.keys.pressed.SHIFT;
		var multiplier = 10;
		if (holdShift)
			multiplier = 1;

		if (upP || rightP || downP || leftP)
		{
			updateTexts();
			if (upP)
				char.animOffsets.get(animList[curAnim])[1] += 1 * multiplier;
			if (downP)
				char.animOffsets.get(animList[curAnim])[1] -= 1 * multiplier;
			if (leftP)
				char.animOffsets.get(animList[curAnim])[0] += 1 * multiplier;
			if (rightP)
				char.animOffsets.get(animList[curAnim])[0] -= 1 * multiplier;

			updateTexts();
			genBoyOffsets(false);
			char.playAnim(animList[curAnim]);
		}

		if (FlxG.keys.pressed.ENTER)
			saveBoyOffsets();

		super.update(elapsed);
	}
}
