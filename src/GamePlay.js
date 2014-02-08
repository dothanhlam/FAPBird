/**
 * Created with JetBrains WebStorm.
 * User: Lam Do
 * Date: 2/7/14
 * Time: 9:23 PM
 * To change this template use File | Settings | File Templates.
 */
FAPBird.GamePlay = function(game) {
    fapBird = null;
    FAP_BIRD = "FAP_BIRD";
    FAPBIRD_SIZE = 64;
    STAGE_WIDTH = 400;
    STAGE_HEIGHT = 640;
    fapBirdTween = null;

    BOUND_Y = STAGE_HEIGHT - FAPBIRD_SIZE  / 2;

    gravity = 0.6;
    wingPower = 5;
    birdVerticleSpeed = 0;
    maxVertSpeedUP = 18;
    vertRoofing = 4;
    vertSpeed = 0;
    maxWing = 2;
    maxVertSpeedDOWN = -8;
    isPlaying = false;
    gainFlight = 0;
    floorPosition = BOUND_Y;
    isFallen = false;

    //game
    isReady = true;

};


FAPBird.GamePlay.prototype = {
    create: function() {
        this.createFAPBird();

    },

    update: function() {
        var fallingSpeed = 0;
        if (isReady) {
            isReady = false;
            if (isPlaying) {
               if (gainFlight > 0) {
                   gainFlight --;
                   vertSpeed +=  wingPower;
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
                if ((((birdVerticleSpeed > 0)) && ((birdVerticleSpeed > maxVertSpeedUP)))){
                    birdVerticleSpeed = maxVertSpeedUP;
                }
                else {
                    if ((((birdVerticleSpeed < 0)) && ((birdVerticleSpeed < maxVertSpeedDOWN)))){
                        birdVerticleSpeed = maxVertSpeedDOWN;
                    }
                }

                if (birdVerticleSpeed == 0){
                    fapBird.rotation = 0;
                    //fap fap fap
                }
                else {
                    if ((((birdVerticleSpeed > 0)) && ((birdVerticleSpeed <= maxWing)))){
                        fapBird.rotation = ((birdVerticleSpeed / maxWing) * -35* (Math.PI / 180));
                        // fap fap
                    }
                    else {
                        if ((((birdVerticleSpeed > 0)) && ((birdVerticleSpeed >= maxWing)))){
                            fapBird.rotation = -35;
                           //fap fap

                        }
                        else {
                            if (birdVerticleSpeed < 0){
                                fapBird.rotation = ((birdVerticleSpeed / maxVertSpeedDOWN) * 90* (Math.PI / 180));
                                //wing middle;

                            }
                        }
                    }
                }

                if (birdVerticleSpeed == 0){
                    fapBird.rotation = 0;
                    //fap fap

                }
                else {
                    if (birdVerticleSpeed > 0){
                        fapBird.rotation = ((birdVerticleSpeed / maxVertSpeedUP) * -35* (Math.PI / 180));
                        //fap fap

                    } else {
                        if (birdVerticleSpeed < 0){
                            fapBird.rotation = ((birdVerticleSpeed / maxVertSpeedDOWN) * 90* (Math.PI / 180));
                           // wing middle;

                        }
                    }
                }
                fapBird.y -= birdVerticleSpeed;

                if (fapBird.y < - FAPBIRD_SIZE / 2){
                    fapBird.y = - FAPBIRD_SIZE / 2;
                }

                if ((((fapBird.y >= (floorPosition - (fapBird.height / 2)))) && (!(this.isFallen)))){
                    fapBird.y = floorPosition - (fapBird.height / 2);
                    this.isFallen = true;
                }
                else {
                    if ((((fapBird.y >= (floorPosition - (fapBird.height / 2)))) && (this.isFallen))){
                        fapBird.y = (floorPosition - (fapBird.height / 2));
                    }
                    else {
                        if (!this.isFallen){

                        }
                    }
                }
            }

           isReady = true;
        }
    },

    createFAPBird: function() {
        var x = (STAGE_WIDTH - FAPBIRD_SIZE) / 2;
        var y = ( FAPBIRD_SIZE) * 3;
        fapBird = this.game.add.sprite(x, y, FAP_BIRD);
        fapBird.name = FAP_BIRD;
        fapBirdTween = this.game.add.tween(fapBird).to({ y: fapBird.y + FAPBIRD_SIZE / 2 }, 500, Phaser.Easing.Quadratic.InOut, true, 0, 1000, true);
        this.game.input.onDown.add(this.clickHandler, this);
    },

    clickHandler: function(event) {
        if (!this.isFallen && !this.ISPlaying) {
            fapBirdTween.stop();
            isPlaying = true;
            gainFlight = 3;
        }
    }
}