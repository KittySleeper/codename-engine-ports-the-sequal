import flixel.util.FlxStringUtil;
import flixel.text.FlxTextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextFormatMarkerPair;
import funkin.backend.system.framerate.Framerate;

var sonicScore;
var sonicTime;
var sonicMisses;

var yellowFormat;
var redFormat;

function new() {
    FlxG.width = 1024;
    camGame.width = 1024;

    if (Framerate.isLoaded)
		Framerate.offset.x = 100;
}

function postCreate() {
    for (uiShit in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt])
        uiShit.kill();

    for (strum in strumLines.members[1]) {
        strum.x -= 70;
        strum.scale.set(0.65, 0.65);
    }

    sonicScore = new FlxText(120, 5, FlxG.width, "SCORE", 50);
    sonicScore.setFormat(Paths.font("HUD.ttf"), 50, FlxColor.WHITE, null, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
    sonicScore.cameras = [camHUD];
    sonicScore.borderSize = 3;
    add(sonicScore);

    sonicTime = new FlxText(120, 50, FlxG.width, "TIME", 50);
    sonicTime.setFormat(Paths.font("HUD.ttf"), 50, FlxColor.WHITE, null, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
    sonicTime.cameras = [camHUD];
    sonicTime.borderSize = 3;
    add(sonicTime);

    sonicMisses = new FlxText(120, 100, FlxG.width, "MISSES", 50);
    sonicMisses.setFormat(Paths.font("HUD.ttf"), 50, FlxColor.WHITE, null, FlxTextBorderStyle.SHADOW, FlxColor.BLACK);
    sonicMisses.cameras = [camHUD];
    sonicMisses.borderSize = 3;
    add(sonicMisses);

    var healthThing = new FlxSprite(100, FlxG.height * 0.85).loadGraphic(Paths.image("picoHealth"));
    healthThing.cameras = [camHUD];
    add(healthThing);

    yellowFormat = new FlxTextFormat(0xFFE0E000);
    redFormat = new FlxTextFormat(0xffe00000);
}

function postUpdate(elapsed) {
    sonicScore.applyMarkup(
        "#SCORE#        " + songScore,
        [new FlxTextFormatMarkerPair(yellowFormat, "#")]
    );

    sonicTime.applyMarkup(
        "#TIME#    " + FlxStringUtil.formatTime((inst.length - Conductor.songPosition) / 1000),
        [new FlxTextFormatMarkerPair(yellowFormat, "#")]
    );

    sonicMisses.applyMarkup(
        "#MISSES#     " + misses,
        [new FlxTextFormatMarkerPair(yellowFormat, "#")]
    );

    if (misses > 0 && !executedTimer)
        textBlinkey();
}

function destroy() {
    FlxG.width = 1280;

    if (Framerate.isLoaded)
		Framerate.offset.x = 0;
}