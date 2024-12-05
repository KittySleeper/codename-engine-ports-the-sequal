import flixel.addons.display.FlxBackdrop;

import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;

import funkin.backend.system.framerate.Framerate;

//i coded the menu options like this just to see if nova would notice my code is different than normal
var menuOptions = ["storymode", "freeplay", "settings", "credits"];
var menuStates = [new StoryMenuState(), new FreeplayState(), new OptionsMenu(), new CreditsMain()];

var menuSprites = [];

var curSelected = 0;

var menuChars;
var stupidTween;

function create() {
    trace("mikudayooooo");

    if (Framerate.isLoaded)
		Framerate.offset.y = 30;

    var bg = new FlxSprite().loadGraphic(Paths.image("menus/miku/back"));
    bg.setGraphicSize(Std.int(bg.width * 1.1));
    bg.screenCenter();
    add(bg);

    var bg2 = new FlxSprite().loadGraphic(Paths.image("menus/miku/back2"));
    bg2.setGraphicSize(Std.int(bg2.width * 1.1));
    bg2.screenCenter();
    add(bg2);

    var bg3 = new FlxSprite().loadGraphic(Paths.image("menus/miku/backx"));
    bg3.setGraphicSize(Std.int(bg3.width * 1.1));
    bg3.screenCenter();
    add(bg3);

    var lines = new FlxBackdrop(Paths.image("menus/miku/lines"));
    lines.velocity.x = 45;
    add(lines);

    menuChars = new FlxSprite(35, 5);
    menuChars.frames = Paths.getSparrowAtlas("menus/miku/menuchars");
    add(menuChars);

    for (i => option in menuOptions) {
        var obj = new FlxSprite(-180 + (i * 40), 50 + (i * 140));
        obj.frames = Paths.getSparrowAtlas("menus/miku/menu_shit");
        menuSprites.push(obj);
        obj.animation.addByPrefix("idle", option + " block");
        obj.animation.addByPrefix("select", option + " select");
        menuChars.animation.addByPrefix(option, option);
        obj.animation.play("idle");
        obj.setGraphicSize(Std.int(obj.width * 0.6));
        add(obj);
    }

    var menuBars = new FlxSprite().loadGraphic(Paths.image("menus/miku/mainmenubars"));
    add(menuBars);

    changeSelection(0);
}

function update(elapsed) {
    if (controls.UP_P)
        changeSelection(-1);
    if (controls.DOWN_P)
        changeSelection(1);

    if (controls.ACCEPT)
        FlxG.switchState(menuStates[curSelected]);

    if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
        persistentUpdate = false;
		persistentDraw = true;
    }

    if (FlxG.keys.justPressed.SEVEN) {
		openSubState(new EditorPicker());
        persistentUpdate = false;
		persistentDraw = true;
    }
}

function changeSelection(amt) {
    menuSprites[curSelected].animation.play("idle");
    
    curSelected += amt;

    if (curSelected >= menuOptions.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = menuOptions.length - 1;

    menuSprites[curSelected].animation.play("select");

    if (stupidTween != null)
        stupidTween.cancel();

    if (amt != 0) {
        stupidTween = FlxTween.tween(menuChars, {x: 500, alpha: 0}, 0.25, {onComplete: function(tween) {
            menuChars.animation.play(menuOptions[curSelected]);
            stupidTween = FlxTween.tween(menuChars, {x: 35, alpha: 1}, 0.25);
        }});
    } else {
        menuChars.animation.play(menuOptions[curSelected]);
    }
}