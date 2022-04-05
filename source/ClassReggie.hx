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

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import flixel.input.keyboard.FlxKey;
import Achievements;

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

    private var camGame:FlxCamera;
    private var camAchievement:FlxCamera;

    override function create():Void
    {
        Paths.clearStoredMemory();
        #if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Uncovering a Secret", 'Reggie Count: ${reggieCounter}', null);
		#end

        camGame = new FlxCamera();
        camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

        FlxG.cameras.reset(camGame);
        FlxG.cameras.add(camAchievement);

        FlxG.cameras.setDefaultDrawTarget(camGame, true);
		FlxG.cameras.setDefaultDrawTarget(camAchievement, false);

        // stop all the songs from the previous state
        FlxG.sound.music.stop();

        // play the menu music and the funny sound
        FlxG.sound.playMusic(Paths.music('freakyMenuOG'), 0);
        FlxG.sound.music.fadeIn(4, 0, 0.7);
        FlxG.sound.play(Paths.sound('boom'));

        reggie = new FlxSprite(-80).loadGraphic(Paths.image('topoworld/randomBS/reggieLmao'));
        reggie.scrollFactor.set(0);
        reggie.setGraphicSize(Std.int(reggie.width * 0.5));
        reggie.updateHitbox();
        reggie.screenCenter();
        reggie.alpha = 0.1;
        reggie.antialiasing = ClientPrefs.globalAntialiasing;
        add(reggie);

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

        #if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		if (reggieCounter > 49) {
			var achieveID:Int = Achievements.getAchievementIndex('reggie');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) {
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

        super.create();
    }

    #if ACHIEVEMENTS_ALLOWED
	// Unlocks "I like guys" achievement
	function giveAchievement() {
		add(new AchievementObject('reggie', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "reggie"');
	}
	#end

    override function update(elapsed:Float)
	{
        daText.text = "";
        daText.text += "YOU SHOULD REALLY DISABLE OPPONENT MODE FOR THIS";
        daText.text += "\nReggie Count: " + reggieCounter;
        daText.text += "\nPress R to clear the Counter\n";
        
        if (FlxG.sound.music.volume < 0.7) {
            FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
        }

        if (controls.BACK) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxG.sound.music.fadeOut();
            LoadingState.loadAndSwitchState(new PlayState());
		}

        if (controls.RESET) {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            reggieCounter = 0;
		}

        if (controls.ACCEPT) {
            FlxG.sound.play(Paths.sound('confirmMenu'));
            CoolUtil.browserLoad('https://youtu.be/Jvv5pCFj-Y8');
		}
    }
}