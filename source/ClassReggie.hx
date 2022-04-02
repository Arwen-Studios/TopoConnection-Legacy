package;

/*
    class to avoid Opponent Mode
    on bimbo's song

    I will probably transform this into
    a gallery someday.

    yes I did put a bit of effort into this
    my bad lol
    - BeastlyGhost
*/

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.input.keyboard.FlxKey;

class ClassReggie extends MusicBeatState
{
    // making this public so PlayState can update it
    public static var reggieCounter:Int = 0;

    // texts
    var daText:FlxText;
    var songDisp:FlxText;
    var engineWatermark:FlxText;

    // this god damn rat
    var reggie:FlxSprite;

    // funny colors!
    var blammableObjects:Array<FlxSprite> = [];

    override function create():Void
    {
        Conductor.changeBPM(102);

        // stop all the songs from the previous state
        FlxG.sound.music.stop();

        // play the funny sound and the menu song
        FlxG.sound.play(Paths.sound('boom'));
        FlxG.sound.playMusic(Paths.music('freakyMenuOG'), 0);
        FlxG.sound.music.fadeIn(4, 0, 0.7);

        reggie = new FlxSprite(-80).loadGraphic(Paths.image('nullClass/reggieLmao'));
        reggie.scrollFactor.set(0);
		reggie.setGraphicSize(Std.int(reggie.width * 0.5));
		reggie.updateHitbox();
		reggie.screenCenter();
        reggie.alpha = 0.1;
        reggie.color = TitleState.blammedLightsColors[0];
		add(reggie);
        blammableObjects.push(reggie);

        daText = new FlxText(0, FlxG.height - 405, 0, "", 16);
		daText.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        daText.x = 250;
		daText.scrollFactor.set();
		daText.borderSize = 1.25;
		add(daText);

        var daHint:FlxText = new FlxText(0, FlxG.height - 64, 0, "HINT: You can double increase the counter by quickly going back to this menu while the transition is still happening.", 16);
        daHint.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		daHint.scrollFactor.set();
        if (reggieCounter > 9 && reggieCounter < 11)
		    add(daHint);

        songDisp = new FlxText(0, FlxG.height - 44, 0, "??? - HARD", 16);
		songDisp.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songDisp.scrollFactor.set();
		add(songDisp);

        engineWatermark = new FlxText(0, FlxG.height - 24, 0, "Reggie Engine v" + MainMenuState.psychEngineVersion, 16);
		engineWatermark.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		engineWatermark.scrollFactor.set();
		add(engineWatermark);

        super.create();
    }

    override function update(elapsed:Float)
	{
        daText.text = "";
        daText.text += "YOU SHOULD REALLY DISABLE OPPONENT MODE FOR THIS";
        daText.text += "\nReggie Count: " + reggieCounter;
        daText.text += "\nPress R to clear the Counter";
        daText.text += "\n";

        if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

        if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			LoadingState.loadAndSwitchState(new PlayState());
		}

        if (controls.RESET) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            reggieCounter = 0;
		}

        if (controls.ACCEPT) {
            CoolUtil.browserLoad('https://youtu.be/o2AiSZ8CU-w'); //Placeholder Link for now, and also this song bangs
		}
    }

    var curLight:Int = 0;
	public static var blammedLightsColors:Array<FlxColor> = [
		0xffff00e4, //purple
		0xffff0036, //red
	];

	override function beatHit()
	{
		if (curBeat % 4 == 0) 
		{
			var randomNum:Int = FlxG.random.int(0, TitleState.blammedLightsColors.length-1, [curLight]);
			var blamColor:FlxColor = TitleState.blammedLightsColors[randomNum];
			for (spr in blammableObjects)
			{
				spr.color = blamColor;
			}
			curLight = randomNum;

			FlxG.camera.zoom = 1.15;
			FlxTween.tween(FlxG.camera, {zoom: 1}, 0.5, {ease: FlxEase.circOut});
		}

		super.beatHit();
	}
}