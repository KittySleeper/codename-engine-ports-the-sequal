import funkin.backend.utils.NativeAPI;
import openfl.system.Capabilities;
import funkin.backend.utils.NdllUtil;
import lime.graphics.Image;

static var redirectStates:Map<FlxState, String> = [
	MainMenuState => "StupidMenuSwitch" // ik its stupid shush your trap
];

function new() {
	if (FlxG.save.data.mainmenu == null)
		FlxG.save.data.mainmenu = "funkin";
}

function update(elapsed) {
	if (FlxG.keys.justPressed.F6)
		NativeAPI.allocConsole();
	if (FlxG.keys.justPressed.F5)
		FlxG.resetState();
}

function preStateSwitch() {
	if (FlxG.save.data.mainmenu != "funkin") {
		for (redirectState in redirectStates.keys()) {
			if (FlxG.game._requestedState is redirectState)
				FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
		}
	}
}