package alternativa.tanks.loader.stylishdishonestprogressbar {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.utils.clearTimeout;
  import flash.utils.getTimer;

  public class StylishDishonestProgressBar extends Sprite {
    private static const progressLineClass:Class = StylishDishonestProgressBar_progressLineClass;
    private static const rightGlowClass:Class = StylishDishonestProgressBar_rightGlowClass;
    private static const DEFAULT_HEIGHT:int = 58;

    private var _progressLine:Bitmap;
    private var _rightGlow:Bitmap;
    private var _complete:Function;
    private var _timeOutComplete:int;
    private var _frameTime:int;
    private var _stage:Stage;
    private var _progress:Number = 0;
    private var _speed:Number = 1;
    private var _isFinish:Boolean = false;

    public function StylishDishonestProgressBar(param1:Function) {
      super();
      this._complete = param1;
      this.init();
    }

    private function init() : void {
      var local1:IDisplay = IDisplay(OSGi.getInstance().getService(IDisplay));
      this._stage = local1.stage;
      this._progressLine = new progressLineClass();
      this._progressLine.height = DEFAULT_HEIGHT;
      this._rightGlow = new rightGlowClass();
      this._rightGlow.height = DEFAULT_HEIGHT;
      addChild(this._progressLine);
      addChild(this._rightGlow);
    }

    public function start() : void {
      this._isFinish = false;
      clearTimeout(this._timeOutComplete);
      addEventListener(Event.RESIZE,this.onResize);
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onResize(param1:Event) : void {
      this.setPercentWidth(this._progress);
    }

    private function onEnterFrame(param1:Event) : void {
      if(this._isFinish) {
        this.onCompleted();
        return;
      }
      if(getTimer() - this._frameTime < 5) {
        return;
      }
      this._frameTime = getTimer();
      this._progress += this._speed;
      if(this._progress >= 100) {
        this._progress = 50;
        this._speed /= 2;
      }
      this.setPercentWidth(this._progress);
    }

    private function setPercentWidth(param1:Number) : void {
      var local2:Number = param1 * (this._stage.stageWidth / 100);
      this._progressLine.width = local2;
      this._rightGlow.x = local2;
    }

    private function onCompleted() : void {
      this._complete.apply();
    }

    public function forciblyFinish() : void {
      this.forciblyStop();
    }

    public function forciblyStop() : void {
      this._isFinish = true;
      removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      removeEventListener(Event.RESIZE,this.onResize);
      clearTimeout(this._timeOutComplete);
    }
  }
}
