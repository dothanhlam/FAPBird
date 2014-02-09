/**
 * Created with JetBrains WebStorm.
 * User: Lam Do
 * Date: 2/7/14
 * Time: 9:23 PM
 * To change this template use File | Settings | File Templates.
 */
FAPBird.GamePlay = function (game) {
    fapBird = null;
    FAP_BIRD = "FAP_BIRD";
    FAPBIRD_SIZE = 32;
    STAGE_WIDTH = 288;
    STAGE_HEIGHT = 512;
    fapBirdTween = null;

    BOUND_Y = STAGE_HEIGHT - FAPBIRD_SIZE / 2;

    gravity = 0.6;
    wingPower = 5;
    birdVerticleSpeed = 0;
    maxVertSpeedUp = 18;
    vertRoofing = 4;
    vertSpeed = 0;
    maxWing = 2;
    maxVertSpeedDown = -8;
    isPlaying = false;
    gainFlight = 0;
    floorPosition = BOUND_Y - 112;
    pipeHole = 150;
    pipePadding = 50;
    isFallen = false;
    isReady = true;
    backStop = false;
    timingPlz = 0;
    //blocks
    movingBlocks = [];

    //assets
    BACKGROUND_DAYLIGHT = "BACKGROUND_DAYLIGHT";
    background = null;

    GET_READY = "GET_READY";
    getReady = null;
    TAP_TAP = "TAP_TAP";
    tap = null;
    introScreen = null;

    LANDING = 'LANDING';
    landing = null;
    scrollingSpeed = 3.4;

    UP_PIPE = 'UP_PIPE';
    DOWN_PIPE = 'DOWN_PIPE';

    GAME_OVER = "GAME_OVER";
    PLAY_BUTTON = "PLAY_BUTTON";
    gameOverScreen = null;
};


FAPBird.GamePlay.prototype = {

    create: function () {
        this.createBackground();
        this.createFAPBird();
    },

    update: function () {
        var fallingSpeed = 0;
        var blockIndex = 0;
        if (isReady) {
            isReady = false;
            if (isPlaying) {
                if (gainFlight > 0) {
                    gainFlight--;
                    vertSpeed += wingPower;
                    if (vertSpeed >= vertRoofing) {
                        fallingSpeed = vertRoofing - vertSpeed;
                        birdVerticleSpeed += vertRoofing;
                        vertSpeed -= fallingSpeed;
                    }
                    else {
                        birdVerticleSpeed += vertSpeed;
                    }
                }
                birdVerticleSpeed -= gravity;
                if ((((birdVerticleSpeed > 0)) && ((birdVerticleSpeed > maxVertSpeedUp)))) {
                    birdVerticleSpeed = maxVertSpeedUp;
                }
                else {
                    if ((((birdVerticleSpeed < 0)) && ((birdVerticleSpeed < maxVertSpeedDown)))) {
                        birdVerticleSpeed = maxVertSpeedDown;
                    }
                }

                if (birdVerticleSpeed == 0) {
                    fapBird.rotation = 0;
                    //fap fap fap
                }
                else {
                    if ((((birdVerticleSpeed > 0)) && ((birdVerticleSpeed <= maxWing)))) {
                        fapBird.rotation = ((birdVerticleSpeed / maxWing) * -35 * (Math.PI / 180));
                        // fap fap
                    }
                    else {
                        if ((((birdVerticleSpeed > 0)) && ((birdVerticleSpeed >= maxWing)))) {
                            fapBird.rotation = -35;
                            //fap fap
                        }
                        else {
                            if (birdVerticleSpeed < 0) {
                                fapBird.rotation = ((birdVerticleSpeed / maxVertSpeedDown) * 90 * (Math.PI / 180));
                                //wing middle;
                            }
                        }
                    }
                }

                if (birdVerticleSpeed == 0) {
                    fapBird.rotation = 0;
                    //fap fap
                }
                else {
                    if (birdVerticleSpeed > 0) {
                        fapBird.rotation = ((birdVerticleSpeed / maxVertSpeedUp) * -35 * (Math.PI / 180));
                        //fap fap
                    }
                    else {
                        if (birdVerticleSpeed < 0) {
                            fapBird.rotation = ((birdVerticleSpeed / maxVertSpeedDown) * 90 * (Math.PI / 180));
                            // wing middle;
                        }
                    }
                }
                fapBird.y -= birdVerticleSpeed;

                if (fapBird.y < -FAPBIRD_SIZE / 2) {
                    fapBird.y = -FAPBIRD_SIZE / 2;
                }

                if ((fapBird.y >= floorPosition - fapBird.height / 2) && !this.isFallen) {
                    fapBird.y = floorPosition - (fapBird.height / 2);
                    this.backStop = false;
                    this.isFallen = true;
                    this.gameOver();
                }
                else {
                    if ((fapBird.y >= floorPosition - fapBird.height / 2) && this.isFallen) {
                        fapBird.y = (floorPosition - (fapBird.height / 2));
                        this.backStop = false;
                        this.gameOver();
                    }
                    else {
                        if (!this.isFallen) {
                            this.backStop = true;
                        }
                    }
                }

                if (this.backStop) {

                }
                //calc hit test area

                if (!this.isFallen) {
                    this.moveBlocks();
                    while (blockIndex < movingBlocks.length) {
                        if (this.isHittingBlock(fapBird, movingBlocks[blockIndex])) {
                            this.isFallen = true;
                            // perform some effect here
                        }
                        blockIndex++;
                    }

                    if (this.backStop) {
                        if (this.timingPlz > 0) {
                            this.timingPlz--;
                        }
                        else {
                            this.timingPlz = 50;
                            this.createBlocks();
                        }
                    }
                }
                else {
                    if (this.isFallen) {
                        this.backStop = true;
                    }
                }
            }
            isReady = true;
        }

        //landing scroll
        if (landing != null && !this.isFallen) {
            landing.x -= scrollingSpeed;
            if (landing.x < -77 / 2) {
                landing.x = 0;
            }
        }
    },

    createFAPBird: function () {
        var x = (STAGE_WIDTH - FAPBIRD_SIZE) / 4;
        var y = (STAGE_HEIGHT - FAPBIRD_SIZE) / 2;
        fapBird = this.game.add.sprite(x, y, FAP_BIRD);
        fapBird.name = FAP_BIRD;
        fapBirdTween = this.game.add.tween(fapBird).to({ y: fapBird.y + FAPBIRD_SIZE / 2 }, 500, Phaser.Easing.Quadratic.InOut, true, 0, 1000, true);
        this.game.input.onDown.add(this.clickHandler, this);
    },

    createBackground: function () {
        background = this.game.add.sprite(0, 0, BACKGROUND_DAYLIGHT);
        introScreen = this.game.add.group();
        getReady = introScreen.create((STAGE_WIDTH - 192) / 2, 56 * 2, GET_READY);
        tap = introScreen.create((STAGE_WIDTH - 116) / 2, getReady.y + 108, TAP_TAP);
        landing = this.game.add.sprite(0, STAGE_HEIGHT - 112, LANDING);
    },

    createBlocks: function () {
        var offset = Math.floor((Math.random() * ((floorPosition - (pipePadding * 2)) - pipeHole)));

        var pipeUp = this.game.add.sprite(320, pipeHole + offset + pipePadding, 'UP_PIPE');
        var pipeDown = this.game.add.sprite(320, offset + pipePadding - 320, 'DOWN_PIPE');

        if (movingBlocks == null) {
            movingBlocks = [];
        }

        movingBlocks.push(pipeUp);
        movingBlocks.push(pipeDown);

        landing.bringToTop();
        fapBird.bringToTop();
    },

    moveBlocks: function () {
        var pipeIndex = 0;
        if (this.backStop) {
            while (pipeIndex < movingBlocks.length) {
                movingBlocks[pipeIndex].x -= 4;
                if (( movingBlocks[pipeIndex].x + movingBlocks[pipeIndex].width) <= 0) {
                    movingBlocks[pipeIndex].destroy();
                    movingBlocks.splice(pipeIndex, 1);
                    pipeIndex--;
                }
                pipeIndex++;
            }
        }
    },

    isHittingBlock: function (a, b) {
        var hit1;
        var hit2;
        if ((a.x > b.x && (a.x < (b.x + b.width)) ||
            ((a.x + a.width > b.x) && (a.x + a.width < b.x + b.width)) ||
            ((b.x > a.x && (b.x < a.x + a.width)) ||
                ((b.x + b.width > a.x) && (b.x + b.width < a.x + a.width))))) {
            hit1 = true;
        }
        else {
            if ((a.x == b.x && (a.x + a.width == b.x + b.width))) {
                hit1 = true;
            }
        }
        if ((a.y > b.y && ((a.y < (b.y + b.height)) ||
            ((a.y + a.height) > b.y) && (a.y + a.height < b.y + b.height)) ||
            ((b.y > a.y && (b.y < a.y + a.height)) ||
                ((b.y + b.height > a.y) && (b.y + b.height < a.y + a.height))))) {
            hit2 = true;
        }
        else {
            if ((a.y == b.y && (a.y + a.height == b.y + b.height))) {
                hit2 = true;
            }
        }
        return (hit1 && hit2);
    },

    gameOver: function () {
        if (gameOverScreen == null) {
            gameOverScreen = this.game.add.group();
            gameOverScreen.create((STAGE_WIDTH - 202) / 2, 56 * 3, GAME_OVER);
            var playButton = gameOverScreen.create((STAGE_WIDTH - 113) / 2, 56 * 3 + 67, PLAY_BUTTON);
            playButton.inputEnabled = true;
            playButton.events.onInputDown.add(this.replayHandler, this);
        }
        else {

        }
    },

    replayHandler: function (event) {
        //reloading the page simply
        location.reload();
    },

    clickHandler: function (event) {
        if (!this.isFallen && !this.isPlaying) {
            fapBirdTween.stop();
            this.game.add.tween(introScreen).to({alpha: 0}, 500, Phaser.Easing.Linear.None, true, 0, 0, false);
            isPlaying = true;
            gainFlight = 3;
        }
    }
}