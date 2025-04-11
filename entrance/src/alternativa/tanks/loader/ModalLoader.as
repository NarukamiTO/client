package alternativa.tanks.loader {
  import alternativa.init.TanksServicesActivator;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.loader.dishonestprogressbar.DishonestProgressBar;
  import alternativa.tanks.utils.TransparentJPG;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;

  public class ModalLoader extends Sprite implements IModalLoaderService {
    private static const WindowRGB:Class = ModalLoader_WindowRGB;
    private static const WindowRGBChina:Class = ModalLoader_WindowRGBChina;
    private static const WindowAlpha:Class = ModalLoader_WindowAlpha;
    private static const DELAY:int = 9000;

    private var _stage:Stage;
    private var layer:DisplayObjectContainer;
    private var windowBmp:Bitmap;
    private var _timer:Timer;
    private var dishonestProgressBar:DishonestProgressBar;
    private var shape:Shape;

    public function ModalLoader() {
      super();
      var local1:IDisplay = IDisplay(TanksServicesActivator.osgi.getService(IDisplay));
      this.layer = local1.loaderLayer;
      this._stage = local1.stage;
      this.addTransparentBackground();
      var local2:BitmapData = getLoaderBackgroundBitmap(TanksServicesActivator.osgi.getService(ILocaleService) as ILocaleService);
      this.windowBmp = TransparentJPG.createImageFromRGBAndAlpha(local2,new WindowAlpha().bitmapData);
      addChild(this.windowBmp);
      this.dishonestProgressBar = new DishonestProgressBar(this.progressBarFinished);
      addChild(this.dishonestProgressBar);
      this.dishonestProgressBar.x = 10;
      this.dishonestProgressBar.y = 239;
      this._timer = new Timer(DELAY,1);
      this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onNextTipTimerComplete);
    }

    private static function getLoaderBackgroundBitmap(param1:ILocaleService) : BitmapData {
      if(param1.language == "cn") {
        return new WindowRGBChina().bitmapData;
      }
      return new WindowRGB().bitmapData;
    }

    private function addTransparentBackground() : void {
      this.shape = new Shape();
      this.shape.graphics.beginFill(0,0);
      this.shape.graphics.drawRect(0,0,1,1);
      this.shape.graphics.endFill();
      addChild(this.shape);
    }

    private function progressBarFinished() : void {
      if(this.layer.contains(this)) {
        this.layer.removeChild(this);
      }
    }

    private function onNextTipTimerComplete(param1:TimerEvent = null) : void {
      var local2:ILoaderTipsService = OSGi.getInstance().getService(ILoaderTipsService) as ILoaderTipsService;
      if(local2 != null) {
        local2.getTip();
      }
      this._timer.stop();
      this._timer.reset();
      this._timer.start();
    }

    public function show() : void {
      if(!this.layer.contains(this)) {
        this.dishonestProgressBar.start();
        this.layer.addChild(this);
        this._stage.addEventListener(Event.RESIZE,this.align);
        this.align();
        this._timer.start();
        this.onNextTipTimerComplete();
      }
    }

    private function align(param1:Event = null) : void {
      this.x = this._stage.stageWidth - this.windowBmp.width >>> 1;
      this.y = this._stage.stageHeight - this.windowBmp.height >>> 1;
      this.shape.width = this._stage.stageWidth;
      this.shape.height = this._stage.stageHeight;
      this.shape.x = -x;
      this.shape.y = -y;
    }

    public function hide() : void {
      if(this.layer.contains(this)) {
        this._timer.stop();
        this.dishonestProgressBar.forciblyFinish();
        this._stage.removeEventListener(Event.RESIZE,this.align);
      }
    }

    public function hideForcibly() : void {
      if(this.layer.contains(this)) {
        this._timer.stop();
        this.dishonestProgressBar.forciblyStop();
        this._stage.removeEventListener(Event.RESIZE,this.align);
        this.layer.removeChild(this);
      }
    }

    public function isVisible() : Boolean {
      return this.layer.contains(this);
    }
  }
}
