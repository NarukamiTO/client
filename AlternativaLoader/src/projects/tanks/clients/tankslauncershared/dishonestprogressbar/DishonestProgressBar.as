package projects.tanks.clients.tankslauncershared.dishonestprogressbar {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Matrix;
  import flash.utils.clearTimeout;
  import flash.utils.setTimeout;
  import projects.tanks.clients.tankslauncershared.service.Locale;

  public class DishonestProgressBar extends Sprite {
    private static const bgdLeftClass:Class = DishonestProgressBar_bgdLeftClass;
    private static const bgdRightClass:Class = DishonestProgressBar_bgdRightClass;
    private static const bgdCenterClass:Class = DishonestProgressBar_bgdCenterClass;
    private static const bgdCenterBitmapData:BitmapData = new bgdCenterClass().bitmapData;
    private static const blickClass:Class = DishonestProgressBar_blickClass;
    private static const blickBitmapData:BitmapData = new blickClass().bitmapData;
    private static const progressLineClass:Class = DishonestProgressBar_progressLineClass;
    private static const DEFAULT_WIDTH:int = 585;
    private static const MAX_PROGRESS_LINE_WIDTH:int = 573;
    private static const DEFAULT_HEIGHT:int = 28;
    private static const FAKE_RIGHT_BORDER_IN_PERCENT:Number = 0.98;
    private static const MIN_STEP:Number = 0.05;
    private static const STEP_DEC:Number = 0.001;
    private static const COMPLETE_DELAY:int = 100;

    private var _progressLineWidth:Number;
    private var _fakeRightLimitProgressLineWidth:int;
    private var _progressLine:Bitmap;
    private var _progressLineBlick:Shape;
    private var _bgdLeftIcon:Bitmap;
    private var _bgdRightIcon:Bitmap;
    private var _bgdCenterIcon:Shape;
    private var _loadingLabel:Bitmap;
    private var _blickMatrix:Matrix;
    private var _complete:Function;
    private var _timeOutComplete:uint;
    private var _isForciblyFinish:Boolean;
    private var _normalStep:Number = 0.05;
    private var _forciblyStep:Number;
    private var _locale:String;

    public function DishonestProgressBar(param1:String, param2:Function) {
      super();
      this._locale = param1;
      this._complete = param2;
      this.init();
    }

    private function init() : void {
      this._fakeRightLimitProgressLineWidth = MAX_PROGRESS_LINE_WIDTH * FAKE_RIGHT_BORDER_IN_PERCENT;
      this._bgdLeftIcon = new bgdLeftClass();
      addChild(this._bgdLeftIcon);
      this._bgdRightIcon = new bgdRightClass();
      addChild(this._bgdRightIcon);
      this._bgdCenterIcon = new Shape();
      addChild(this._bgdCenterIcon);
      this._progressLine = new progressLineClass();
      this._progressLine.x = 6;
      this._progressLine.y = 4;
      this._progressLine.width = 0;
      this._progressLine.blendMode = BlendMode.OVERLAY;
      addChild(this._progressLine);
      this._progressLineBlick = new Shape();
      this._progressLineBlick.x = this._progressLine.x;
      this._progressLineBlick.y = this._progressLine.y;
      this._progressLineBlick.blendMode = BlendMode.ADD;
      this._progressLineBlick.alpha = 0.5;
      addChild(this._progressLineBlick);
      this._loadingLabel = new Bitmap(LoadingLabel.getLocalizedBitmapData(this._locale));
      addChild(this._loadingLabel);
      this.resize();
      addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
    }

    private function resize() : void {
      this._bgdCenterIcon.graphics.clear();
      this._bgdCenterIcon.graphics.beginBitmapFill(bgdCenterBitmapData);
      this._bgdCenterIcon.graphics.drawRect(0,0,DEFAULT_WIDTH - this._bgdLeftIcon.width - this._bgdRightIcon.width,DEFAULT_HEIGHT);
      this._bgdCenterIcon.x = this._bgdLeftIcon.width;
      this._bgdRightIcon.x = this._bgdCenterIcon.x + this._bgdCenterIcon.width;
      var local1:int = 26;
      if(this._locale == Locale.CN) {
        local1 = 22;
      }
      this._loadingLabel.x = DEFAULT_WIDTH - (this._loadingLabel.width - local1) >> 1;
      this._loadingLabel.y = -this._loadingLabel.height - 17;
    }

    private function onAddedToStage(param1:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      this.align();
      stage.addEventListener(Event.RESIZE,this.onResize);
      addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveToStage);
    }

    private function onResize(param1:Event) : void {
      this.align();
    }

    private function align() : void {
      this.x = stage.stageWidth - this.width >> 1;
      this.y = stage.stageHeight - DEFAULT_HEIGHT >> 1;
    }

    private function onRemoveToStage(param1:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveToStage);
      stage.removeEventListener(Event.RESIZE,this.onResize);
    }

    public function start() : void {
      clearTimeout(this._timeOutComplete);
      this._isForciblyFinish = false;
      this._progressLine.width = 0;
      this._progressLineBlick.graphics.clear();
      this._progressLineWidth = 0;
      this._blickMatrix = new Matrix();
      this._normalStep = 1;
      addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event) : void {
      if(this._isForciblyFinish) {
        this._progressLineWidth += this._forciblyStep;
        if(this._progressLineWidth >= MAX_PROGRESS_LINE_WIDTH) {
          removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
          this._progressLineWidth = MAX_PROGRESS_LINE_WIDTH;
          this._timeOutComplete = setTimeout(this.onCompleted,COMPLETE_DELAY);
        }
      } else {
        this._normalStep -= STEP_DEC;
        if(this._normalStep < MIN_STEP) {
          this._normalStep = MIN_STEP;
        }
        this._progressLineWidth += this._normalStep;
        if(this._progressLineWidth >= this._fakeRightLimitProgressLineWidth) {
          this._progressLineWidth = this._fakeRightLimitProgressLineWidth;
        }
      }
      this.redrawProgressLineAndBlick(this._progressLineWidth);
      this._blickMatrix.tx += 3;
      if(this._blickMatrix.tx > blickBitmapData.width) {
        this._blickMatrix.tx = -this._blickMatrix.tx % blickBitmapData.width;
      }
    }

    public function forciblyFinish() : void {
      this._forciblyStep = (MAX_PROGRESS_LINE_WIDTH - this._progressLineWidth) / 10;
      this._isForciblyFinish = true;
    }

    private function onCompleted() : void {
      this._complete.apply();
    }

    private function redrawProgressLineAndBlick(param1:int) : void {
      this._progressLine.width = param1;
      this._progressLineBlick.graphics.clear();
      this._progressLineBlick.graphics.beginBitmapFill(blickBitmapData,this._blickMatrix,true,false);
      this._progressLineBlick.graphics.drawRect(0,0,param1,this._progressLine.height);
    }

    public function stop() : void {
      removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
    }
  }
}
