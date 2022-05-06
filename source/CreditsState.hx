package;

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
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	// for the portraits
	var portSpr:FlxSprite;
	var hasPortrait:Array<String> = []; // members that do have a portrait
	var noPortrait:Array<String> = []; // members that don't have a portrait
	var person:String;

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var isPaused:Bool = false;

	var offsetThing:Float = -75;

	override function create()
	{
		#if DISCORD_FEATURE
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", 'Reading the Credits', null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [
			/**
			 * Name
			 * Icon name
			 * Description
			 * Link
			 * BG Color
			 * Sound
			**/
			['Topo Connection Team'],
			[
				'NxtVithor',
				'os-cara/vito',
				'Project Lead and Designer\n"I love the person down below."',
				'https://twitter.com/NxtVithor',
				'e78ee6',
				'Vithor_Sound',
				'os-cara/ports/vito'
			],
			[
				'BeastlyMaxx',
				'os-cara/maxx',
				"Director, Musician\n\"i DONT KNOW WHAT TO SAY" + '"',
				'https://twitter.com/BeastlyMaxxVivi',
				'353535',
				'Maxx_Sound',
				'os-cara/ports/maxx'
			],
			[
				'BeastlyChip',
				'os-cara/chip',
				'Director, Musician\n"Hold my amen breaks"',
				'https://twitter.com/BeastlyChip',
				'e295ff',
				'Chip_Sound',
				'os-cara/ports/chip'
			],
			[
				'BeastlyGhost',
				'os-cara/ghost',
				'Director, Coder\n"Just happy to be here!"',
				'https://twitter.com/Fan_de_RPG',
				'00ffbf',
				'Ghost_Sound',
				'os-cara/ports/ghost'
			],
			[
				'LazyBudd',
				'os-cara/lazy',
				'Director, Musician\n"I love sex"',
				'https://twitter.com/DaLazy_Composer',
				'a529e0',
				'Lazy_Sound',
				'os-cara/ports/lazy'
			],
			[
				'Senshi_Z',
				'os-cara/senshi',
				'Director, Musician\n"dislexia."',
				'https://twitter.com/Senshi_Z12',
				'bbffb1',
				'Senshi_Sound',
				'os-cara/ports/senshi'
			],
			[''],
			['Artists'],
			[
				'BeastlyMudoku',
				'os-cara/mudoku',
				"Sprite Artist\n\"I don't owe you anything" + '"',
				'https://twitter.com/Mudoku__',
				'80ffa1',
				'Shiny_Sound',
				'os-cara/ports/shiny'
			],
			[
				'BeastlyYoshi',
				'os-cara/yoshi',
				"Background Artist\n\"It's a crime to use amen break, whoever does it will go to hell immediately." + '"',
				'https://twitter.com/yoshizitosNG',
				'481874',
				'Yoshi_Sound',
				'os-cara/ports/yoshi'
			],
			[
				'LoopiPie',
				'os-cara/loopiii',
				'External Art and Resources\n"they forgot about me but i\'m here"',
				'https://twitter.com/oopyBoo',
				'ff5656',
				'Loopy_Sound',
				'os-cara/ports/loopiii'
			],
			[
				'Suok',
				'os-cara/suok',
				'Spriter, Animator\n"*starts beatboxing in Pennywise*"',
				'https://twitter.com/oSuOk3',
				'ff0062',
				'Suok_Sound',
				'os-cara/ports/suok'
			],
			[
				'Brycee',
				'os-cara/brycee',
				'Spriter\n"You should never ask Vithor if he likes ass."',
				'https://twitter.com/Bryceegay',
				'aa6abb',
				'Brycee_Sound',
				'os-cara/ports/brycee'
			],
			[
				'AquaStrikr',
				'os-cara/aqua',
				'Spriter, Judgement Designer\n"agoti rip-off"',
				'https://twitter.com/aqua_strikr',
				'd4d4d4',
				'Aqua_Sound',
				'os-cara/ports/aqua'
			],
			[
				'NaferNightmare',
				'os-cara/nafer',
				'Animator, made the Cutscenes\n"exactly like my balls, get it?"',
				'https://twitter.com/NaferNightmare',
				'ffb600',
				'Nafer_Sound',
				'os-cara/ports/nafer'
			],
			[''],
			['Sound and Music Designer'],
			[
				'BeastlyShiny',
				'os-cara/shiny',
				"Nxxty's Voice Actor\n\"meow meow meow meow meow meow" + '"',
				'https://twitter.com/shinyshyni_',
				'c5c5c5',
				'Shiny_Sound',
				'os-cara/ports/shiny'
			],
			[
				'JulianoBeta',
				'os-cara/juliano',
				'Made da funny songs\n"r.i.p triple trouble"',
				'https://twitter.com/JulianoIts',
				'1c2080',
				'Juliano_Sound',
				'os-cara/ports/juliano'
			],
			[''],
			['Coders'],
			[
				'Luis com "S"',
				'os-cara/luis',
				"Coder\n\"I'm lazy AF" + '"',
				'https://twitter.com/Luis_comS_10',
				'c29c6e',
				'Luis_Sound',
				'os-cara/ports/luis'
			],
			[
				'Gazozoz',
				'os-cara/gazozoz',
				'Coder, Animator\n"How does this affect O GREMIO?"',
				'https://twitter.com/Gazozoz_',
				'9c2323',
				'Gazozoz_Sound',
				'os-cara/ports/gazozoz'
			],
			[
				'Luca',
				'os-cara/luca',
				'Coder\n"*boo-womp*"',
				'https://twitter.com/lucabio545?t=pGC6DDvaF7gJz07pWXYPcQ&s=09',
				'ebe610',
				'Luca_Sound',
				'os-cara/ports/luca'
			],
			[''],
			['Charters'],
			[
				'Mathesu',
				'os-cara/matt',
				'Charter\n"I can chart you"',
				'https://twitter.com/MattPogg',
				'2c2c2c',
				'Matt_Sound',
				'os-cara/ports/matt'
			],
			[''],
			['Special Thanks'],
			[
				'Blueballs Incident',
				'special-thx/bbincident',
				'Our biggest inspiration for this mod\nNxt (AKA Vithor) just loves this mod and so we credited it!',
				'https://gamebanana.com/mods/293462',
				'e1e4a1',
				'BBIncident_Sound',
				'special-thx/ports/trollge'
			],
			[
				"Hypno's Lullaby",
				'special-thx/lullaby',
				"One of our inspirations for this mod, this one is actually\none of Ghost's personal favorites.",
				'https://gamebanana.com/mods/332345',
				'F5E54B',
				'Hypno_Sound',
				'special-thx/ports/hypno'
			],
			[
				"B3 Remixed",
				'special-thx/B3',
				"Thanks for being one of the best remix mods out there\nour Nom cover wouldn't exist without this mod!\n(Nxt loves this song lmao!!!!!!).",
				'https://gamebanana.com/mods/332345',
				'55fa57',
				'B3_Sound',
				'special-thx/B3'
			],
			[
				'Hotline 024',
				'special-thx/hotline024',
				"Huge Inspiration for the Game HUD and overhaul it's a incredible mod.",
				'https://gamejolt.com/games/arrowfunk/646058',
				'cc0053',
				'Hotline024_Sound',
				'special-thx/ports/hotline024'
			],
			[
				'Arrow Funk',
				'special-thx/arrowfunk',
				'Overhaul, a great mod made by some pretty awesome people, I recommend it.',
				'https://gamejolt.com/games/arrowfunk/646058',
				'52A4FF',
				'ArrowFunk_Sound',
				'special-thx/ports/arrowfunk'
			],
			[
				'NebulaZorua',
				'special-thx/nebula',
				"Made the Code used for the in-game modifiers.\nthey didn't really work on this mod but I wanted to credit them regardless\nIcon is from FNF: D-Sides. (I ALSO RECOMMEND THIS MOD!!!)",
				'https://twitter.com/Nebula_Zorua',
				'B300B3',
				'Placeholder_Sound', // reminder that *I should find/make a sound for him!!!!*
				'special-thx/ports/nebula'
			],
			[''],
			['Psych Engine Team'],
			[
				'Shadow Mario',
				'shadowmario',
				'Main Programmer of Psych Engine\n"WikiHow: How to handle fame."',
				'https://twitter.com/Shadow_Mario_',
				'444444',
				'JingleShadow'
			],
			[
				'RiverOaken',
				'riveroaken',
				'Main Artist/Animator of Psych Engine',
				'https://twitter.com/RiverOaken',
				'C30085',
				'JingleRiver'
			],
			[
				'shubs',
				'shubs',
				'Additional Programmer of Psych Engine',
				'https://twitter.com/yoshubs',
				'279ADC',
				'JingleShubs'
			],
			[''],
			['Former Engine Members'],
			[
				'bb-panzu',
				'bb-panzu',
				'Ex-Programmer of Psych Engine',
				'https://twitter.com/bbsub3',
				'389A58',
				'JingleBB'
			],
			[''],
			['Engine Contributors'],
			[
				'iFlicky',
				'iflicky',
				'Composer of Psync and Tea Time\nMade the Dialogue Sounds',
				'https://twitter.com/flicky_i',
				'AA32FE',
				''
			],
			[
				'SqirraRNG',
				'gedehari',
				'Chart Editor\'s Sound Waveform base',
				'https://twitter.com/gedehari',
				'FF9300',
				''
			],
			[
				'PolybiusProxy',
				'polybiusproxy',
				'.MP4 Video Loader Extension',
				'https://twitter.com/polybiusproxy',
				'FFEAA6',
				''
			],
			[
				'Keoiki',
				'keoiki',
				'Note Splash Animations',
				'https://twitter.com/Keoiki_',
				'FFFFFF',
				''
			],
			[
				'Smokey',
				'smokey',
				'Spritemap Texture Support',
				'https://twitter.com/Smokey_5_',
				'4D5DBD',
				''
			],
			[''],
			["Funkin' Crew"],
			[
				'ninjamuffin99',
				'ninjamuffin99',
				"Programmer of Friday Night Funkin'",
				'https://twitter.com/ninja_muffin99',
				'F73838',
				''
			],
			[
				'PhantomArcade',
				'phantomarcade',
				"Animator of Friday Night Funkin'",	
				'https://twitter.com/PhantomArcade3K',
				'FFBB1B',
				''
			],
			[
				'evilsk8r',
				'evilsk8r',
				"Artist of Friday Night Funkin'",
				'https://twitter.com/evilsk8r',
				'53E52C',
				''
			],
			[
				'kawaisprite',
				'kawaisprite',
				"Composer of Friday Night Funkin'",
				'https://twitter.com/kawaisprite',
				'6475F3',
				''
			]
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, creditsStuff[i][0], !isSelectable, false);
			optionText.isMenuItem = true;
			optionText.screenCenter(X);
			optionText.yAdd -= 70;
			if(isSelectable) {
				optionText.x -= 70;
			}
			optionText.forceX = optionText.x;
			//optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font(Std.string(Main.gameFont)), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		var blackBox:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 100, FlxColor.BLACK);
		blackBox.scrollFactor.set();
		blackBox.alpha = 0.6;
		add(blackBox);

		var keyText:FlxText = new FlxText(0, 4, FlxG.width, "SHIFT // PAUSE MENU SONG\nSPACE // PLAY PERSON'S SOUND\nENTER // ACCESS SOCIALS", 32);
		keyText.setFormat(Paths.font(Std.string(Main.gameFont)), 32, FlxColor.WHITE, CENTER);
		keyText.scrollFactor.set();
		add(keyText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-1 * shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(1 * shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(FlxG.keys.justPressed.ENTER) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if(FlxG.keys.justPressed.SHIFT && !isPaused) {
				FlxG.sound.music.fadeOut();
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					FlxG.sound.music.pause();
					isPaused = true;
				});
			}
			else if(FlxG.keys.justPressed.SHIFT && isPaused) {
				FlxG.sound.music.resume();
				FlxG.sound.music.fadeIn();
				isPaused = false;
			}
			if(FlxG.keys.justPressed.SPACE) {
				FlxG.sound.play(Paths.sound('credits/' + creditsStuff[curSelected][5]));
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());

				if (isPaused) {
					FlxG.sound.music.fadeIn();
					isPaused = false;
				}

				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.isBold)
			{
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
					item.forceX = item.x;
				}
				else
				{
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
					item.forceX = item.x;
				}
			}
		}

		noPortrait = [
			'ShadowMario',
			'RiverOaken',
			'shubs',
			'bb-panzu',
			'iFlicky',
			'SqirraRNG',
			'PolybiusProxy',
			'Keoiki',
			'Smokey',
			'ninjamuffin99',
			'PhantomArcade',
			'evilsk8r',
			'kawaisprite'
		];
		/*person = hasPortrait[curSelected];
		portSpr.loadGraphic(Paths.image('credits/portraits/' + person));

		if (hasPortrait.contains(person)) {
			portSpr.visible = true;
		} else {
			portSpr.visible = false;
		}*/

		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
