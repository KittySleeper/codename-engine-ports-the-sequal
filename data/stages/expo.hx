var simpSongs = ["disappearance", "siu", "aishite", "popipo"];

function create() {
    if (curSong != "endless") {
        crowdbump.alpha = if (simpSongs.contains(curSong)) 0 else 1;
        bunch_of_simps.alpha = if (simpSongs.contains(curSong)) 1 else 0;
    }
}

function beatHit() {
    if (crowdbump.animation.curAnim.finished && curBeat % 2 == 0)
        crowdbump.playAnim("idle");

    bunch_of_simps.playAnim("idle");
}

function onPlayerHit(e) {
    if (combo == 10) {
        crowdbump.playAnim("cheer");
        dad.playAnim("hey");
    }
}

function onPlayerMiss(e) {
    if (combo >= 10)
        crowdbump.playAnim("miss");
}