package alternativa.tanks.bg {
  import alternativa.init.TanksServicesActivator;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.display.IDisplay;
  import flash.display.BitmapData;
  import flash.display.DisplayObjectContainer;
  import flash.display.Shape;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.geom.Rectangle;

  public class BackgroundService implements IBackgroundService {
    private static const bitmapBg:Class = BackgroundService_bitmapBg;
    private static const bgBitmap:BitmapData = new bitmapBg().bitmapData;

    private var osgi:OSGi;
    private var stage:Stage;
    private var bgLayer:DisplayObjectContainer;
    private var bg:Shape;
    private var bgCropRect:Rectangle;

    public function BackgroundService() {
      super();
      this.osgi = TanksServicesActivator.osgi;
      var local1:IDisplay = this.osgi.getService(IDisplay) as IDisplay;
      this.stage = local1.stage;
      this.bgLayer = local1.backgroundLayer;
      this.bg = new Shape();
    }

    public function showBg() : void {
      if(!this.bgLayer.contains(this.bg)) {
        this.redrawBg();
        this.bgLayer.addChild(this.bg);
        this.stage.addEventListener(Event.RESIZE,this.redrawBg);
      }
    }

    public function hideBg() : void {
      if(this.bgLayer.contains(this.bg)) {
        this.stage.removeEventListener(Event.RESIZE,this.redrawBg);
        this.bgLayer.removeChild(this.bg);
      }
    }

    public function drawBg(param1:Rectangle = null) : void {
      this.bgCropRect = param1;
      this.redrawBg();
    }

    private function redrawBg(param1:Event = null) : void {
      this.bg.graphics.clear();
      this.bg.graphics.beginBitmapFill(bgBitmap);
      this.bg.graphics.drawRect(0,0,this.stage.stageWidth,this.stage.stageHeight);
      if(this.bgCropRect != null) {
        this.bg.graphics.drawRect(this.bgCropRect.x,this.bgCropRect.y,this.bgCropRect.width,this.bgCropRect.height);
      }
    }
  }
}
