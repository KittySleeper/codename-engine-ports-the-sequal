function addCamZoom(amt) {
    defaultCamZoom += Std.parseFloat(amt);

    trace(defaultCamZoom);
}

function shakeCam() {
    FlxG.camera.shake(0.025, 0.2);
}

function noteSpin() {
    for (strumLine in strumLines.members) {
        for (strum in strumLine.members) {
            FlxTween.tween(strum, {angle: strum.angle + 180}, 0.05, {onComplete: function(tween) {
                FlxTween.tween(strum, {angle: 0}, 0.1);
            }});
        }
    }
}