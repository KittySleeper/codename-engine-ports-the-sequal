function update(elapsed) {
    trace(FlxG.save.data.mainmenu);

    FlxG.switchState(new ModState("menus/" + FlxG.save.data.mainmenu + "/MainMenuState"));
}