package alternativa.tanks.models.battle.gui.inventory.readytouse {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.events.Event;
  import flash.geom.ColorTransform;
  import flash.geom.Matrix;
  import flash.utils.getTimer;

  public class LightPillarEffect extends Shape {
    public static var barClass:Class = LightPillarEffect_barClass;
    public static var barBitmapData:BitmapData = (new barClass() as Bitmap).bitmapData;
    public static var topClass:Class = LightPillarEffect_topClass;
    public static var topBitmapData:BitmapData = (new topClass() as Bitmap).bitmapData;

    private static const DURATION_MS:int = 500;
    private static const HEIGHT:int = 500;
    private static const matrix:Matrix = new Matrix();
    private static const colorTransform:ColorTransform = new ColorTransform();

    private var startTime:int;
    private var running:Boolean;

    public function LightPillarEffect() {
      super();
      visible = false;
    }

    public function init(param1:uint) : void {
      colorTransform.color = param1;
      transform.colorTransform = colorTransform;
    }

    public function update(param1:int) : void {
      var local2:Number = NaN;
      if(!this.running) {
        return;
      }
      if(param1 > this.startTime + DURATION_MS) {
        this.stop();
        return;
      }
      local2 = (param1 - this.startTime) / DURATION_MS;
      this.alpha = -(2 * local2 - 1) * (2 * local2 - 1) + 0.8;
      var local3:int = local2 * HEIGHT;
      graphics.clear();
      matrix.ty = HEIGHT - local3;
      graphics.beginBitmapFill(topBitmapData,matrix,true);
      graphics.drawRect(0,HEIGHT - local3,topBitmapData.width,Math.min(local3,topBitmapData.height));
      graphics.endFill();
      if(local3 > topBitmapData.height) {
        graphics.beginBitmapFill(barBitmapData,null,false);
        graphics.drawRect(0,HEIGHT - local3 + topBitmapData.height,barBitmapData.width,local3 - topBitmapData.height);
        graphics.endFill();
      }
    }

    public function start() : void {
      this.running = true;
      this.startTime = getTimer();
      visible = true;
      alpha = 0;
    }

    public function stop() : void {
      visible = false;
      this.running = false;
      dispatchEvent(new Event(Event.COMPLETE));
    }

    override public function get height() : Number {
      return HEIGHT;
    }
  }
}
