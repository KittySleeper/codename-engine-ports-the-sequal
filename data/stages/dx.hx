var dxNoteCam;
var stupidFuckingCamera;

function create() {
    introLength = -1;

    dxNoteCam = new FlxCamera();
    dxNoteCam.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(dxNoteCam, true);

    stupidFuckingCamera = new FlxCamera();
    stupidFuckingCamera.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(stupidFuckingCamera, true);

    FlxG.cameras.add(camHUD, false);
}

function postCreate() {
    FlxG.camera.zoom = 1.5;
    FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 1.85);

    camHUD.fade(FlxColor.BLACK, 1.85, true);

    camFollow.setPosition(500, 1100);

    strumLines.members[0].cameras = [dxNoteCam];

    for (strum in strumLines.members[0]) {
        strum.scrollFactor.set(1, 1);
        strum.setPosition(3000, 2150 + (strum.ID * 100));
        strum.noteAngle = 90;
    }

    for (obj in [lifebox, frontbg])
        obj.cameras = [stupidFuckingCamera];

    for (i => char in strumLines.members[0].characters) {
        char.alpha = if (i == 0) 1 else 0.001;
        char.cameras = [stupidFuckingCamera];
    }

    for (char in strumLines.members[1].characters)
        char.cameras = [stupidFuckingCamera];
}

function update(elapsed) {
    stupidFuckingCamera.zoom = dxNoteCam.zoom = FlxG.camera.zoom;
    stupidFuckingCamera.scroll.x = dxNoteCam.scroll.x = FlxG.camera.scroll.x;
    stupidFuckingCamera.scroll.y = dxNoteCam.scroll.y = FlxG.camera.scroll.y;
}

function onNoteCreation(e){
    e.note.forceIsOnScreen = true;
}

function changePhase(phase) {
    if (phase == "2") {
        camZooming = false;
        FlxTween.tween(FlxG.camera, {zoom: 0.85}, 1.45);
        new FlxTimer().start(1.65, function(timer) {
            strumLines.members[0].characters[0].alpha = 0.0001;
            strumLines.members[0].characters[1].alpha = 1;
        });
    }

    if (phase == "3") {
        strumLines.members[0].characters[1].alpha = 0.0001;
        strumLines.members[0].characters[2].alpha = 1;
    }
}

function beatDrop() {
    faggot = !faggot;
}

function redThing() {
    for (bgParts in [backbg, bushes, sky])
        FlxTween.color(bgParts, 0.35, bgParts.color, FlxColor.RED, {onComplete: function(tween) {
            bgParts.color = FlxColor.WHITE;
    }});
}