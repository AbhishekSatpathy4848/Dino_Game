const frameDuration = 0.08;
const totalDinoSpritesNumber = 24;
//[startIndex, endIndex]
const idleDinoSprites = [0, 3];
const runningDinoSprites = [4, 10];
const kickDinoSprites = [11, 13];
const hitDinoSprites = [14, 16];
const sprintDinoSprites = [17, 23];

int getIdleDinoSpritesNumber() => idleDinoSprites[1] - idleDinoSprites.first;
int getRunningDinoSpritesNumber() =>
    runningDinoSprites[1] - runningDinoSprites.first;
int getKickDinoSpritesNumber() => kickDinoSprites[1] - kickDinoSprites.first;
int getHitDinoSpritesNumber() => hitDinoSprites[1] - hitDinoSprites.first;
int getSprintDinoSpritesNumber() =>
    sprintDinoSprites[1] - sprintDinoSprites.first;

const baseVelocity = 10.0;
