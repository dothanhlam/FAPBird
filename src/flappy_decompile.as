package {
    import flash.media.*;

    public dynamic class hitfx extends Sound {

    }
}//package 
?package Tutorial_File_fla {
    import flash.events.*;
    import flash.media.*;
    import flash.display.*;
    import flash.text.*;
    import adobe.utils.*;
    import flash.accessibility.*;
    import flash.desktop.*;
    import flash.errors.*;
    import flash.external.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.globalization.*;
    import flash.net.*;
    import flash.net.drm.*;
    import flash.printing.*;
    import flash.profiler.*;
    import flash.sampler.*;
    import flash.sensors.*;
    import flash.system.*;
    import flash.text.ime.*;
    import flash.text.engine.*;
    import flash.ui.*;
    import flash.utils.*;
    import flash.xml.*;

    public dynamic class MainTimeline extends MovieClip {

        public var PLAYBUTTON:MovieClip;
        public var masky:MovieClip;
        public var ScoreKeeper:TextField;
        public var background2:MovieClip;
        public var FlashingThing:MovieClip;
        public var BirdyHit:MovieClip;
        public var Birdy:MovieClip;
        public var tutorial1:MovieClip;
        public var AUDIOFIXER:audiofix;
        public var FlapFX:wingfx;
        public var DieFX:diefx;
        public var HitFX:hitfx;
        public var PointFX:pointfx;
        public var isReady:Boolean;
        public var pipePadding:int;
        public var pipehole:int;
        public var pipelength:int;
        public var BACKSTOP;
        public var Points:uint;
        public var Gravity:Number;
        public var WingPower:Number;
        public var BirdVerticleSpeed:Number;
        public var MaxVertSpeedUP:Number;
        public var VertRoofing:Number;
        public var VertSpeed:Number;
        public var MaxWing:Number;
        public var MaxVertSpeedDOWN:Number;
        public var ISPlaying:Boolean;
        public var GainFlight:uint;
        public var FloorPosition:uint;
        public var Timingplz:uint;
        public var JustGraphics:Shape;
        public var isFallen:Boolean;
        public var isALLOWED:Boolean;
        public var isALLOWED2:Boolean;
        public var BlocksMoving:Array;
        public var AwardBlocks:Array;

        public function MainTimeline(){
            addFrameScript(0, this.frame1);
        }
        public function TickTock(_arg1:Event):void{
            var _local2:Number;
            var _local3:int;
            var _local4:int;
            var _local5:MovieClip;
            var _local6:PU;
            var _local7:MovieClip;
            var _local8:PD;
            var _local9:MovieClip;
            var _local10:Sprite;
            if (this.isReady){
                this.isReady = false;
                if (this.ISPlaying){
                    if (this.GainFlight > 0){
                        this.GainFlight--;
                        this.VertSpeed = (this.VertSpeed + this.WingPower);
                        if (this.VertSpeed >= this.VertRoofing){
                            _local2 = (this.VertRoofing - this.VertSpeed);
                            this.BirdVerticleSpeed = (this.BirdVerticleSpeed + this.VertRoofing);
                            this.VertSpeed = (this.VertSpeed - _local2);
                        } else {
                            this.BirdVerticleSpeed = (this.BirdVerticleSpeed + this.VertSpeed);
                        };
                    };
                    this.BirdVerticleSpeed = (this.BirdVerticleSpeed - this.Gravity);
                    if ((((this.BirdVerticleSpeed > 0)) && ((this.BirdVerticleSpeed > this.MaxVertSpeedUP)))){
                        this.BirdVerticleSpeed = this.MaxVertSpeedUP;
                    } else {
                        if ((((this.BirdVerticleSpeed < 0)) && ((this.BirdVerticleSpeed < this.MaxVertSpeedDOWN)))){
                            this.BirdVerticleSpeed = this.MaxVertSpeedDOWN;
                        };
                    };
                    if (this.BirdVerticleSpeed == 0){
                        this.Birdy.rotation = 0;
                        this.FlapFlap();
                    } else {
                        if ((((this.BirdVerticleSpeed > 0)) && ((this.BirdVerticleSpeed <= this.MaxWing)))){
                            this.Birdy.rotation = ((this.BirdVerticleSpeed / this.MaxWing) * -35);
                            this.FlapFlap();
                        } else {
                            if ((((this.BirdVerticleSpeed > 0)) && ((this.BirdVerticleSpeed >= this.MaxWing)))){
                                this.Birdy.rotation = -35;
                                this.FlapFlap();
                            } else {
                                if (this.BirdVerticleSpeed < 0){
                                    this.Birdy.rotation = ((this.BirdVerticleSpeed / this.MaxVertSpeedDOWN) * 90);
                                    this.Birdy.gotoAndPlay("wing_middle");
                                };
                            };
                        };
                    };
                    if (this.BirdVerticleSpeed == 0){
                        this.Birdy.rotation = 0;
                        this.FlapFlap();
                    } else {
                        if (this.BirdVerticleSpeed > 0){
                            this.Birdy.rotation = ((this.BirdVerticleSpeed / this.MaxVertSpeedUP) * -35);
                            this.FlapFlap();
                        } else {
                            if (this.BirdVerticleSpeed < 0){
                                this.Birdy.rotation = ((this.BirdVerticleSpeed / this.MaxVertSpeedDOWN) * 90);
                                this.Birdy.gotoAndPlay("wing_middle");
                            };
                        };
                    };
                    this.Birdy.y = (this.Birdy.y - this.BirdVerticleSpeed);
                    if (this.Birdy.y < -23){
                        this.Birdy.y = -23;
                    };
                    if ((((this.Birdy.y >= (this.FloorPosition - (this.BirdyHit.height / 2)))) && (!(this.isFallen)))){
                        this.Birdy.y = (this.FloorPosition - (this.BirdyHit.height / 2));
                        this.BACKSTOP = false;
                        this.PLAYBUTTON.visible = true;
                        setChildIndex(this.PLAYBUTTON, (numChildren - 1));
                        this.isALLOWED = false;
                        trace("Ow!");
                        this.HitFX.play();
                        this.isFallen = true;
                        setChildIndex(this.FlashingThing, (numChildren - 1));
                        this.FlashingThing.play();
                    } else {
                        if ((((this.Birdy.y >= (this.FloorPosition - (this.BirdyHit.height / 2)))) && (this.isFallen))){
                            this.Birdy.y = (this.FloorPosition - (this.BirdyHit.height / 2));
                            this.BACKSTOP = false;
                            this.PLAYBUTTON.visible = true;
                            setChildIndex(this.PLAYBUTTON, (numChildren - 1));
                            this.isALLOWED = false;
                        } else {
                            if (!this.isFallen){
                                this.BACKSTOP = true;
                            };
                        };
                    };
                    if (this.BACKSTOP){
                        if (this.background2.totalFrames == this.background2.currentFrame){
                            this.background2.gotoAndStop(1);
                        } else {
                            this.background2.nextFrame();
                            this.background2.nextFrame();
                        };
                    };
                    this.BirdyHit.y = (this.Birdy.y - (this.BirdyHit.height / 2));
                    this.BirdyHit.x = (this.Birdy.x - (this.BirdyHit.width / 2));
                    if (!this.isFallen){
                        this.MoveBlocks();
                        this.JustGraphics.graphics.clear();
                        _local3 = 0;
                        _local3 = 0;
                        while (_local3 < this.BlocksMoving.length) {
                            if (this.IsContact(this.BirdyHit, this.BlocksMoving[_local3])){
                                trace("Ow!");
                                this.DieFX.play();
                                this.HitFX.play();
                                this.isFallen = true;
                                setChildIndex(this.FlashingThing, (numChildren - 1));
                                this.FlashingThing.play();
                            };
                            _local3++;
                        };
                        _local3 = 0;
                        while (_local3 < this.AwardBlocks.length) {
                            if (this.IsContact(this.BirdyHit, this.AwardBlocks[_local3])){
                                trace("Yay!");
                                this.PointFX.play();
                                this.AwardBlocks.splice(_local3, 1);
                                this.Points++;
                                this.ScoreKeeper.text = ("" + this.Points);
                                _local3--;
                            };
                            _local3++;
                        };
                        if (this.BACKSTOP){
                            if (this.Timingplz > 0){
                                this.Timingplz--;
                            } else {
                                this.Timingplz = 50;
                                _local4 = Math.floor((Math.random() * ((this.FloorPosition - (this.pipePadding * 2)) - this.pipehole)));
                                _local5 = new MovieClip();
                                _local5.x = 320;
                                _local5.y = 0;
                                _local6 = new PU();
                                _local5.addChild(_local6);
                                _local5.y = ((-(_local6.height) + _local4) + this.pipePadding);
                                _local7 = new MovieClip();
                                _local7.x = 320;
                                _local7.y = ((_local4 + this.pipehole) + this.pipePadding);
                                _local8 = new PD();
                                _local8.y = 0;
                                _local7.addChild(_local8);
                                _local9 = new MovieClip();
                                _local10 = new Sprite();
                                _local10.graphics.beginFill(0, 1);
                                _local10.graphics.drawRect(0, 0, (52 / 2), ((_local4 + this.pipePadding) - ((_local4 + this.pipehole) + this.pipePadding)));
                                _local9.addChild(_local10);
                                _local9.x = (320 + _local10.width);
                                _local9.y = (_local4 + this.pipePadding);
                                this.BlocksMoving.push(_local5);
                                this.BlocksMoving.push(_local7);
                                addChild(this.BlocksMoving[(this.BlocksMoving.length - 1)]);
                                addChild(this.BlocksMoving[(this.BlocksMoving.length - 2)]);
                                this.AwardBlocks.push(_local9);
                                setChildIndex(this.Birdy, (numChildren - 1));
                                setChildIndex(this.background2, (numChildren - 1));
                                this.Birdy.mask = this.masky;
                            };
                        };
                    } else {
                        if (this.isFallen){
                            this.BACKSTOP = false;
                        };
                    };
                };
                this.isReady = true;
            };
        }
        public function FlapFlap():void{
            if (this.Birdy.currentLabel != "fly_fast"){
                this.Birdy.gotoAndPlay("fly_fast");
            };
        }
        public function FlapWing(_arg1):void{
            if (this.isALLOWED2){
                if (((((this.ISPlaying) && (!(this.isFallen)))) && (this.isALLOWED))){
                    this.GainFlight = 2;
                    this.BirdVerticleSpeed = 0;
                    this.FlapFX.play();
                } else {
                    if (((((!(this.isFallen)) && (!(this.ISPlaying)))) && (this.isALLOWED))){
                        this.ISPlaying = true;
                        this.tutorial1.visible = false;
                        this.GainFlight = 3;
                        this.FlapFX.play();
                    };
                };
            } else {
                this.isALLOWED2 = true;
            };
        }
        public function MoveBlocks():void{
            var _local1:int;
            if (this.BACKSTOP){
                _local1 = 0;
                _local1 = 0;
                while (_local1 < this.BlocksMoving.length) {
                    this.BlocksMoving[_local1].x = (this.BlocksMoving[_local1].x - 4);
                    if ((this.BlocksMoving[_local1].x + this.BlocksMoving[_local1].width) <= 0){
                        trace("Block Removed", this.BlocksMoving[_local1].x);
                        removeChild(this.BlocksMoving[_local1]);
                        this.BlocksMoving.splice(_local1, 1);
                        _local1--;
                    };
                    _local1++;
                };
                _local1 = 0;
                while (_local1 < this.AwardBlocks.length) {
                    this.AwardBlocks[_local1].x = (this.AwardBlocks[_local1].x - 4);
                    if ((this.AwardBlocks[_local1].x + this.AwardBlocks[_local1].width) <= 0){
                        trace("Award Block Removed", this.AwardBlocks[_local1].x);
                        this.AwardBlocks.splice(_local1, 1);
                        _local1--;
                    };
                    _local1++;
                };
            };
        }
        public function IsContact(_arg1, _arg2):Boolean{
            var _local3:Boolean;
            var _local4:Boolean;
            if ((((((((((_arg1.x > _arg2.x)) && ((_arg1.x < (_arg2.x + _arg2.width))))) || (((((_arg1.x + _arg1.width) > _arg2.x)) && (((_arg1.x + _arg1.width) < (_arg2.x + _arg2.width))))))) || ((((_arg2.x > _arg1.x)) && ((_arg2.x < (_arg1.x + _arg1.width))))))) || (((((_arg2.x + _arg2.width) > _arg1.x)) && (((_arg2.x + _arg2.width) < (_arg1.x + _arg1.width))))))){
                _local3 = true;
            } else {
                if ((((_arg1.x == _arg2.x)) && (((_arg1.x + _arg1.width) == (_arg2.x + _arg2.width))))){
                    _local3 = true;
                };
            };
            if ((((((((((_arg1.y > _arg2.y)) && ((_arg1.y < (_arg2.y + _arg2.height))))) || (((((_arg1.y + _arg1.height) > _arg2.y)) && (((_arg1.y + _arg1.height) < (_arg2.y + _arg2.height))))))) || ((((_arg2.y > _arg1.y)) && ((_arg2.y < (_arg1.y + _arg1.height))))))) || (((((_arg2.y + _arg2.height) > _arg1.y)) && (((_arg2.y + _arg2.height) < (_arg1.y + _arg1.height))))))){
                _local4 = true;
            } else {
                if ((((_arg1.y == _arg2.y)) && (((_arg1.y + _arg1.height) == (_arg2.y + _arg2.height))))){
                    _local4 = true;
                };
            };
            if (((_local3) && (_local4))){
                return (true);
            };
            return (false);
        }
        public function RestartGame(_arg1):void{
            this.PLAYBUTTON.visible = false;
            this.isReady = true;
            this.pipePadding = 50;
            this.pipehole = 100;
            this.pipelength = 65;
            this.BirdyHit.visible = false;
            this.BACKSTOP = true;
            this.Points = 0;
            this.Gravity = 0.6;
            this.WingPower = 5;
            this.BirdVerticleSpeed = 0;
            this.MaxVertSpeedUP = 14;
            this.VertRoofing = 4;
            this.VertSpeed = 0;
            this.MaxWing = 2;
            this.MaxVertSpeedDOWN = -8;
            this.ISPlaying = false;
            this.GainFlight = 0;
            this.FloorPosition = 412;
            this.Timingplz = 50;
            this.isFallen = false;
            this.Birdy.gotoAndPlay("fly_slow");
            var _local2:int;
            _local2 = 0;
            while (_local2 < this.BlocksMoving.length) {
                trace("Block Removed", this.BlocksMoving[_local2].x);
                removeChild(this.BlocksMoving[_local2]);
                this.BlocksMoving.splice(_local2, 1);
                _local2--;
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.AwardBlocks.length) {
                trace("Award Block Removed", this.AwardBlocks[_local2].x);
                this.AwardBlocks.splice(_local2, 1);
                _local2--;
                _local2++;
            };
            this.Birdy.x = 159;
            this.Birdy.y = 240;
            this.tutorial1.visible = true;
            this.BirdyHit.x = 159;
            this.BirdyHit.y = 240;
            this.ScoreKeeper.text = "0";
            this.Birdy.rotation = 0;
            this.isALLOWED = true;
            this.isALLOWED2 = false;
        }
        function frame1(){
            this.ScoreKeeper.text = "0";
            this.AUDIOFIXER = new audiofix();
            this.AUDIOFIXER.play(0, Infinity);
            stage.quality = StageQuality.LOW;
            this.PLAYBUTTON.addEventListener(MouseEvent.CLICK, this.RestartGame);
            this.tutorial1.visible = true;
            this.FlapFX = new wingfx();
            this.DieFX = new diefx();
            this.HitFX = new hitfx();
            this.PointFX = new pointfx();
            this.isReady = true;
            this.FlashingThing.gotoAndStop(7);
            this.pipePadding = 50;
            this.pipehole = 100;
            this.pipelength = 65;
            this.BirdyHit.visible = false;
            this.PLAYBUTTON.visible = false;
            this.BACKSTOP = true;
            this.Points = 0;
            this.Gravity = 0.6;
            this.WingPower = 5;
            this.BirdVerticleSpeed = 0;
            this.MaxVertSpeedUP = 14;
            this.VertRoofing = 4;
            this.VertSpeed = 0;
            this.MaxWing = 2;
            this.MaxVertSpeedDOWN = -8;
            this.ISPlaying = false;
            this.GainFlight = 0;
            this.FloorPosition = 412;
            this.Timingplz = 50;
            this.JustGraphics = new Shape();
            this.isFallen = false;
            this.isALLOWED = true;
            this.isALLOWED2 = true;
            stage.addEventListener(MouseEvent.MOUSE_DOWN, this.FlapWing);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.FlapWing);
            addEventListener(Event.ENTER_FRAME, this.TickTock);
            this.Birdy.gotoAndPlay("fly_slow");
            addChild(this.JustGraphics);
            this.BlocksMoving = [];
            this.AwardBlocks = [];
        }

    }
}//package Tutorial_File_fla 
?package Tutorial_File_fla {
    import flash.display.*;

    public dynamic class FlappyBird_5 extends MovieClip {

        public function FlappyBird_5(){
            addFrameScript(0, this.frame1, 1, this.frame2, 2, this.frame3, 19, this.frame20, 28, this.frame29);
        }
        function frame1(){
            stop();
        }
        function frame2(){
            stop();
        }
        function frame3(){
            stop();
        }
        function frame20(){
            gotoAndPlay("fly_slow");
        }
        function frame29(){
            gotoAndPlay("fly_fast");
        }

    }
}//package Tutorial_File_fla 
?package Tutorial_File_fla {
    import flash.display.*;

    public dynamic class flashplz_9 extends MovieClip {

        public function flashplz_9(){
            addFrameScript(6, this.frame7);
        }
        function frame7(){
            stop();
        }

    }
}//package Tutorial_File_fla 
?package Tutorial_File_fla {
    import flash.display.*;

    public dynamic class Background_Moving_2 extends MovieClip {

        public function Background_Moving_2(){
            addFrameScript(0, this.frame1);
        }
        function frame1(){
            stop();
        }

    }
}//package Tutorial_File_fla 
?package {
    import flash.media.*;

    public dynamic class audiofix extends Sound {

    }
}//package 
?package {
    import flash.media.*;

    public dynamic class wingfx extends Sound {

    }
}//package 
?package {
    import flash.media.*;

    public dynamic class pointfx extends Sound {

    }
}//package 
?package {
    import flash.display.*;

    public dynamic class PU extends MovieClip {

    }
}//package 
?package {
    import flash.media.*;

    public dynamic class diefx extends Sound {

    }
}//package 
?package {
    import flash.media.*;

    public dynamic class SWOOSH extends Sound {

    }
}//package 
?package {
    import flash.display.*;

    public dynamic class PD extends MovieClip {

    }
}//package