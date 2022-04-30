package options;

#if desktop
import Discord.DiscordClient;
#end
#if GAMEJOLT_ALLOWED
import data.GameJolt;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = [
		'Accessibility',
		'Adjust Offset',
		'Appearance',
		'Controls',
		#if GAMEJOLT_ALLOWED
		'Gamejolt',
		'Gameplay'
		#else
		'Gameplay',
		'Exit to the Main Menu'
		#end
		/*'Note Colors',*/
	];
	public static var cameFromPause:Bool = false;
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Accessibility':
				openSubState(new options.AccessibilitySubState());
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Appearance':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Note Colors':
				openSubState(new options.NotesSubState());
			case 'Adjust Offset':
				LoadingState.loadAndSwitchState(new options.NoteOffsetState());
			#if GAMEJOLT_ALLOWED
			case 'Gamejolt':
				MusicBeatState.switchState(new GameJoltLogin());
			#end
			case 'Exit to the Main Menu':
				cameFromPause = false;
				PauseSubState.playStateToOp = false;
				MusicBeatState.switchState(new MainMenuState());
				
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create() {
		#if desktop
		DiscordClient.changePresence("In the Menus", "Options Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('optionsDesat'));
		bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		/*var titleText:Alphabet = new Alphabet(0, 0, "General", true, false, 0, 0.6);
		titleText.x += 60;
		titleText.y += 90;
		titleText.alpha = 0.4;
		add(titleText);

		var titleNotice:Alphabet = new Alphabet(0, 0, "Page 1", true, false, 0, 0.6);
		titleNotice.x += 70;
		titleNotice.y += 40;
		titleNotice.alpha = 0.4;
		add(titleNotice);*/

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true, false);
		selectorRight = new Alphabet(0, 0, '<', true, false);
		add(selectorLeft);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if(PauseSubState.playStateToOp) {
                LoadingState.loadAndSwitchState(new PlayState());
				PauseSubState.playStateToOp = false;
			} else {
                MusicBeatState.switchState(new MainMenuState());
			}
		}

		if (controls.ACCEPT) {
			openSelectedSubstate(options[curSelected]);
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}