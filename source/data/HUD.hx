/* unfinished.

package data;

import flixel.FlxG;
import flixel.FlxBasic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;
import Song.SwagSong;

class HUD extends FlxTypedGroup<FlxBasic>
{
    public static var instance:HUD;
    public static var SONG:SwagSong = null;
    public var scoreBar:FlxText;
    public var scoreBarTween:FlxTween;
    public var botplayTxt:FlxText;
    public var botplaySine:Float = 0;
    public var songDisp:FlxText;
    public var songAuthor:FlxText;
    public var nps:Int = 0;
    public var maxNPS:Int = 0;

    // will be used later
    public var healthBarBG:AttachedSprite;
    public var healthBar:FlxBar;
    public var timeBarBG:AttachedSprite;
    public var timeBar:FlxBar;

    var notesHitArray = PlayState.notesHitArray;
    
    public function new()
    {
        super();

        instance = this;

        scoreBar = new FlxText(0, PlayState.instance.healthBarBG.y + 36, FlxG.width, "", 20);
        scoreBar.setFormat(Paths.font("mode-seven.ttf"), 20, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreBar.scrollFactor.set();
        scoreBar.borderSize = 1.25;
        scoreBar.visible = !ClientPrefs.hideHud;
        add(scoreBar);

        songDisp = new FlxText(0, FlxG.height - 24, 0, SONG.song + " - " + CoolUtil.difficultyString(), 16);
        songDisp.setFormat(Paths.font("mode-seven.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songDisp.scrollFactor.set();
        add(songDisp);

        botplayTxt = new FlxText(395, PlayState.instance.timeBarBG.y + 55, FlxG.width - 800, "BOTPLAY", 32);
        if(ClientPrefs.downScroll)
            botplayTxt.y = PlayState.instance.timeBarBG.y - 78;
        if(ClientPrefs.middleScroll) {
            if(ClientPrefs.downScroll)
                botplayTxt.y = botplayTxt.y - 78;
            else
                botplayTxt.y = botplayTxt.y + 78;
        }
        botplayTxt.setFormat(Paths.font("mode-seven.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        botplayTxt.scrollFactor.set();
        botplayTxt.borderSize = 2;
        botplayTxt.visible = PlayState.instance.cpuControlled;
        add(botplayTxt);
    }

    override public function update(elapsed:Float)
    {
        // update NPS
        for(i in 0...notesHitArray.length)
		{
			var cock:Date = notesHitArray[i];
			if (cock != null)
				if (cock.getTime() + 2000 < Date.now().getTime())
				notesHitArray.remove(cock);
		}
			nps = Math.floor(notesHitArray.length / 2);
			if (nps > maxNPS)
				maxNPS = nps;

        
        var divider:String = ' - ';

		scoreBar.text = '';
		scoreBar.text += (ClientPrefs.npsDisplay ? 'NPS: ${nps}/${maxNPS}${divider}Score: ${PlayState.instance.songScore}' : 'Score: ${PlayState.instance.songScore}');
		scoreBar.text += divider + 'Misses: ${PlayState.instance.songMisses}';

		var accuracyDisplay = ClientPrefs.accuracyDisplay;
		if (accuracyDisplay)
		{
			scoreBar.size = 16;
			if (PlayState.instance.ratingName == '?')
				scoreBar.text += divider + 'Accuracy: 0%';
			else
				scoreBar.text += divider + 'Accuracy: ${Highscore.floorDecimal(PlayState.instance.ratingPercent * 100, 2)}%';
			
			if (PlayState.instance.ratingFC != '')
				scoreBar.text += divider + '[${PlayState.instance.ratingFC}] ${PlayState.instance.ratingName}';
			else
				scoreBar.text += divider + '${PlayState.instance.ratingName}';
		}

        if (PlayState.isStoryMode)
		{
			PlayState.instance.detailsText = WeekData.getCurrentWeek().weekName + " - " + scoreBar.text;
		} else {
			PlayState.instance.detailsText = scoreBar.text;
		}

        if(botplayTxt.visible) {
			botplaySine += 180 * elapsed;
			botplayTxt.alpha = 1 - Math.sin((Math.PI * botplaySine) / 180);
		}
    }
}

*/