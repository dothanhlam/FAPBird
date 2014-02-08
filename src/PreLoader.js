/**
 * Created with JetBrains WebStorm.
 * User: Lam Do
 * Date: 2/7/14
 * Time: 9:23 PM
 * To change this template use File | Settings | File Templates.
 */

FAPBird = {};
FAPBird.PreLoader = function(game) {

};

FAPBird.PreLoader.prototype = {
    preload: function() {
        this.load.image('FAP_BIRD', 'assets/fuufap.png');
        this.load.image('BACKGROUND_DAYLIGHT', 'assets/background-daylight.png');
        this.load.image('GET_READY','assets/get-ready.png');
        this.load.image('TAP_TAP','assets/tap-tap.png');
        this.load.image('LANDING','assets/landing.png');
        this.load.image('UP_PIPE','assets/up-pipe.png');
        this.load.image('DOWN_PIPE','assets/down-pipe.png');

    },

    create: function() {
        this.initGameSettings();
        this.game.state.start('GamePlay');
    },

    initGameSettings: function() {
        this.game.input.maxPointers = 1;
        this.game.stage.disableVisibilityChange = true;
        this.game.stage.backgroundColor = 0x71C5CF;

        if (this.game.device.desktop) {
            this.game.stage.scale.pageAlignHorizontally = true;
        }
        else {
            this.game.stage.scaleMode = Phaser.StageScaleMode.SHOW_ALL;
        }
    }
};