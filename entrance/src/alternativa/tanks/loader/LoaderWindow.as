package alternativa.tanks.loader {
  import alternativa.init.TanksServicesActivator;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.stylishdishonestprogressbar.StylishDishonestProgressBar;
  import controls.Label;
  import flash.display.Bitmap;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.KeyboardEvent;
  import flash.events.TimerEvent;
  import flash.filters.DropShadowFilter;
  import flash.utils.Timer;
  import flash.utils.setTimeout;

  public class LoaderWindow extends Sprite implements ILoaderWindowService {
    private static const backFade:Class = LoaderWindow_backFade;
    private static const back:Class = LoaderWindow_back;
    private static const bg:Class = LoaderWindow_bg;
    private static const NEXT_TIP_DELAY:int = 10000;
    private static const _backBitmapPadding:int = 60;
    private static const ENTER_KEY_CODE:int = 32;

    private var _backFadeBitmap:Bitmap;
    private var _backBitmap:Bitmap;
    private var _bgBitmap:Bitmap;
    private var layer:DisplayObjectContainer;
    private var _tipLabel:Label = new Label();
    private var _titleLabel:Label = new Label();
    private var _stage:Stage;
    private var _nextTipTimer:Timer;
    private var _tips:Array = [];
    private var _currentTip:int = 0;
    private var _dishonestProgressBar:StylishDishonestProgressBar;
    private var _localeService:ILocaleService;
    private var _hideRequested:Boolean;

    public function LoaderWindow() {
      super();
      this._localeService = OSGi.getInstance().getService(ILocaleService) as ILocaleService;
      this._tips = this._localeService.getTextWithPrefix("TIP_").sort(randomize);
      var local1:IDisplay = IDisplay(TanksServicesActivator.osgi.getService(IDisplay));
      this.layer = local1.loaderLayer;
      this._stage = local1.stage;
      this._stage.addEventListener(Event.RESIZE,this.onResize);
      this._bgBitmap = new bg();
      addChild(this._bgBitmap);
      this._backFadeBitmap = new backFade();
      addChild(this._backFadeBitmap);
      this._backBitmap = new back();
      addChild(this._backBitmap);
      this._dishonestProgressBar = new StylishDishonestProgressBar(this.progressBarFinished);
      addChild(this._dishonestProgressBar);
      addChild(this._tipLabel);
      addChild(this._titleLabel);
      this._nextTipTimer = new Timer(NEXT_TIP_DELAY);
      this._nextTipTimer.addEventListener(TimerEvent.TIMER,this.onNextTipTimerComplete);
    }

    private static function randomize(param1:*, param2:*) : int {
      return Math.random() > 0.5 ? 1 : -1;
    }

    private function progressBarFinished() : void {
      if(this._stage.contains(this)) {
        this._stage.removeChild(this);
      }
    }

    private function onNextTipTimerComplete(param1:TimerEvent = null) : void {
      this.changeTip();
      this.align();
    }

    public function show() : void {
      this._hideRequested = false;
      if(!this._stage.contains(this)) {
        this._dishonestProgressBar.start();
        this._stage.addChild(this);
        this._stage.addEventListener(Event.RESIZE,this.align);
        this._stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyPressed);
        this.align();
        this._nextTipTimer.start();
        this.onNextTipTimerComplete();
      }
    }

    public function showDelayed(param1:int) : void {
      this._hideRequested = false;
      setTimeout(this.showDelayedAfterTimeout,param1);
    }

    private function showDelayedAfterTimeout() : void {
      if(!this._hideRequested) {
        this.show();
        this._hideRequested = false;
      }
    }

    private function changeTip() : void {
      ++this._currentTip;
      this._tipLabel.text = this._tips[this._currentTip % this._tips.length];
    }

    private function onKeyPressed(param1:KeyboardEvent) : void {
      if(param1.keyCode == ENTER_KEY_CODE) {
        this.changeTip();
      }
    }

    private function onResize(param1:Event = null) : void {
      this.align();
    }

    private function align(param1:Event = null) : void {
      this._bgBitmap.x = 0;
      this._bgBitmap.y = 0;
      this._bgBitmap.width = this._stage.stageWidth;
      this._bgBitmap.height = this._stage.stageHeight;
      this._backFadeBitmap.width = this._stage.stageWidth;
      this._backFadeBitmap.height = 320;
      this._backFadeBitmap.x = 0;
      this._backFadeBitmap.y = this._stage.stageHeight - this._backFadeBitmap.height;
      this._backBitmap.width = this._stage.stageWidth;
      this._backBitmap.height = 102;
      this._backBitmap.x = 0;
      this._backBitmap.y = this._stage.stageHeight - this._backBitmap.height - _backBitmapPadding;
      this._dishonestProgressBar.x = 0;
      this._dishonestProgressBar.y = this._stage.stageHeight - (this._dishonestProgressBar.height >>> 1) - (this._backFadeBitmap.height >>> 1);
      this._tipLabel.size = 16;
      this._tipLabel.align = "center";
      this._tipLabel.multiline = true;
      this._tipLabel.wordWrap = true;
      this._tipLabel.width = 590;
      this._tipLabel.x = (this._stage.stageWidth >>> 1) - (this._tipLabel.width >>> 1);
      this._tipLabel.y = this._backBitmap.y + (this._backBitmap.height >>> 1) - (this._tipLabel.height >>> 1);
      this._tipLabel.filters = [new DropShadowFilter()];
      this._titleLabel.size = 20;
      this._titleLabel.align = "center";
      this._titleLabel.text = this._localeService.getText("LOADER_HEADER").toUpperCase();
      this._titleLabel.bold = true;
      this._titleLabel.x = this._stage.stageWidth / 2 - (this._titleLabel.width >>> 1);
      this._titleLabel.y = this._stage.stageHeight - this._backBitmap.height - 100;
      this._titleLabel.filters = [new DropShadowFilter()];
    }

    public function hide() : void {
      this._hideRequested = true;
      if(this._stage.contains(this)) {
        this._nextTipTimer.stop();
        this._dishonestProgressBar.forciblyFinish();
        this._stage.removeEventListener(Event.RESIZE,this.onResize);
        this._stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyPressed);
        this._stage.removeChild(this);
      }
    }

    public function hideForcibly() : void {
      this._hideRequested = true;
      if(this._stage.contains(this)) {
        this._nextTipTimer.stop();
        this._dishonestProgressBar.forciblyStop();
        this._stage.removeEventListener(Event.RESIZE,this.onResize);
        this._stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyPressed);
        this._stage.removeChild(this);
      }
    }

    public function isInProgress() : Boolean {
      return this._nextTipTimer.running;
    }
  }
}
