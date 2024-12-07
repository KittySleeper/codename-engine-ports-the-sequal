function beatHit() {
    if (crowd.animation.curAnim.finished && curBeat % 2 == 0)
        crowd.playAnim("idle");
}

function onPlayerHit(e) {
    if (combo == 10) {
        crowd.playAnim("cheer");
        dad.playAnim("hey");
    }
}