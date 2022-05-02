import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

using StringTools;

// basically Reset Score without the icons lol

class ExitSubState extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var alphabetArray:Array<Alphabet> = [];

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	var onYes:Bool = false;
	var yesText:Alphabet;
	var noText:Alphabet;

	public function new()
	{
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = 0;
		bg.scrollFactor.set();
		add(bg);

		var text:Alphabet = new Alphabet(20, 180, "Quit the Game?", true);
		text.screenCenter(X);
		alphabetArray.push(text);
		text.alpha = 0;
		add(text);

		yesText = new Alphabet(0, text.y + 110, 'Yes', true);
		yesText.screenCenter(X);
		yesText.x -= 20;
		add(yesText);

		noText = new Alphabet(0, yesText.y + 120, 'No', true);
		noText.screenCenter(X);
		noText.x -= 20;
		add(noText);

		selectorLeft = new Alphabet(0, 0, '>', true, false);
		selectorRight = new Alphabet(0, 0, '<', true, false);
		add(selectorLeft);
		add(selectorRight);

		updateOptions();
	}

	override function update(elapsed:Float)
	{
		bg.alpha += elapsed * 1.5;
		if(bg.alpha > 0.6) bg.alpha = 0.6;

		for (i in 0...alphabetArray.length) {
			var spr = alphabetArray[i];
			spr.alpha += elapsed * 2.5;
		}

		if(controls.UI_DOWN_P || controls.UI_UP_P) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 1);
			onYes = !onYes;
			updateOptions();
		}
		if(controls.ACCEPT) {
			if(onYes) {
				Sys.exit(0);
			}
			if(!onYes) {
				close();
			}
		}
		super.update(elapsed);
	}

	function updateOptions() {
		var scales:Array<Float> = [0.75, 1];
		var alphas:Array<Float> = [0.6, 1.25];
		var confirmInt:Int = onYes ? 1 : 0;

		if (onYes) {
			selectorLeft.x = yesText.x - 63;
			selectorLeft.y = yesText.y;
			selectorRight.x = yesText.x + yesText.width + 15;
			selectorRight.y = yesText.y;
		}

		if (!onYes) {
			selectorLeft.x = noText.x - 63;
			selectorLeft.y = noText.y;
			selectorRight.x = noText.x + noText.width + 15;
			selectorRight.y = noText.y;
		}

		yesText.alpha = alphas[confirmInt];
		yesText.scale.set(scales[confirmInt], scales[confirmInt]);
		noText.alpha = alphas[1 - confirmInt];
		noText.scale.set(scales[1 - confirmInt], scales[1 - confirmInt]);
	}
}