package;

/*
    this class is used for the song ratings
    there's no functions on it because when it comes to Ratings
    Psych Engine only works properly with arrays
    although I could just make a better system, this should work for now

    check PlayState.hx
    line: 4630
    - BeastlyGhost
*/

class Ratings extends MusicBeatState
{
    // Default Ratings
    public static var topoRatings:Array<Dynamic> = [
        ['Skill Issue', 0.2], //0%-19%
        ['Get better bro', 0.4], //20%-39%
        ['Play more osu little one', 0.5], //40%-49%
        ['Try Spamming', 0.6], //50%-59%
        ['Okay...', 0.69], //60%-68%
        ['I like this number', 0.7], //69%
        ['Almost there', 0.8], //70%-79%
        ['Good Job', 0.9], //80%-89%
        ['Thats my man', 1], //90%-99%
        ['Legend!', 1] //100%
    ];

    // Psych Engine's Default Ratings
    public static var psychRatings:Array<Dynamic> = [
        ['You Suck!', 0.2], //0%-19%
        ['Shit', 0.4], //20%-39%
        ['Bad', 0.5], //40%-49%
        ['Bruh', 0.6], //50%-59%
        ['Meh', 0.69], //60%-68%
        ['Nice', 0.7], //69%
        ['Good', 0.8], //70%-79%
        ['Great', 0.9], //80%-89%
        ['Sick!', 1], //90%-99%
        ['Perfect!!', 1] //100%
    ];

    // Ratings for "Nuzlocke"
    public static var nuzlockeRatings:Array<Dynamic> = [
        ['Whited out!', 0.2], //0%-19%
        ['Wooper', 0.4], //20%-39%
        ['Badly Poisoned', 0.5], //40%-49%
        ['Low EVs', 0.6], //50%-59%
        ['Gen 8 lover', 0.69], //60%-68%
        ['Nice', 0.7], //69%
        ['Almost got it!', 0.8], //70%-79%
        ['Gotcha!', 0.9], //80%-89%
        ['High IVs', 1], //90%-99%
        ['Legendary!!', 1] //100%
    ];

    // Ratings for "Ghost"
    public static var ghostRatings:Array<Dynamic> = [
        ['', 0.2], //0%-19%
        ['', 0.4], //20%-39%
        ['', 0.5], //40%-49%
        ['', 0.6], //50%-59%
        ['', 0.69], //60%-68%
        ['', 0.7], //69%
        ['', 0.8], //70%-79%
        ['', 0.9], //80%-89%
        ['', 1], //90%-99%
        ['', 1] //100%
    ];

    // Ratings for "Lazy"
    public static var lazyRatings:Array<Dynamic> = [
        ['', 0.2], //0%-19%
        ['', 0.4], //20%-39%
        ['', 0.5], //40%-49%
        ['', 0.6], //50%-59%
        ['', 0.69], //60%-68%
        ['', 0.7], //69%
        ['', 0.8], //70%-79%
        ['', 0.9], //80%-89%
        ['', 1], //90%-99%
        ['', 1] //100%
    ];
}