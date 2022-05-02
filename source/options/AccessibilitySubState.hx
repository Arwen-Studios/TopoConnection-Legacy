package options;

#if DISCORD_FEATURE
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
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

class AccessibilitySubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Accessibility Settings';
		rpcTitle = 'Accessibility Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Allow Shaders in Game',
			"If unchecked, in-game Shaders will be ignored, making it easier on your eyes.",
			'shaders',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Pan on Hit',
			"If unchecked, the camera will stay still when hitting a note.",
			'camFollow',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooming on Beat Hit',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Shake on Event',
			"If unchecked, the camera and HUD won't shake on Screen Shake event.",
			'camShake',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		super();
	}
}