package;

/*
    this class is used for the song ratings
    there's no functions on it because when it comes to Ratings
    Psych Engine only works properly with arrays
    although I could just make a better system, this should work for now

    - BeastlyGhost
*/

class Ratings extends MusicBeatState
{
    /*
        Week 1 + Secret Weeks
        Default Ratings
    */
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
        ['Legend!!', 1] //100%
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

    // Ratings for "Bimbo / Deez Nuts"
    public static var bimboRatings:Array<Dynamic> = [
        ["A", 0.401], // 40%
        ["AA", 0.6], // 59%
        ["AAA", 0.7], // 69%
        ["AAAA", 0.8], // 79%
        ["AAAAA", 0.86], // 85%
        ["AAAAAA", 0.9], // 89%
        ["AAAAAAA", 0.96], // 95%
        ["AAAAAAAA", 0.976], // 97.5%
        ["AAAAAAAAA", 0.981], // 98%
        ["AAAAAAAAAA", 0.986], // 98.5%
        ["AAAAAAAAAAA", 0.991], // 99%
        ["AAAAAAAAAAAA", 0.9936], // 99.35%
        ["AAAAAAAAAAAAA", 0.9959], // 99.58%
        ["AAAAAAAAAAAAAA", 0.998], // 99.79%
        ["AAAAAAAAAAAAAAA", 0.9989], // 99.88%
        ["AAAAAAAAAAAAAAAA", 0.9999], // 99.97%
        ["AAAAAAAAAAAAAAAAA", 1], // 99.99%
        ["AAAAAAAAAAAAAAAAAA!!", 1] // 100%
    ];
}