package alternativa.tanks.gui.device.list {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Graphics;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class DeviceBorder extends Sprite {
    private static const MIN_SINGLE_BUTTON_HEIGHT:int = 104;
    private static const MIN_DOUBLE_BUTTON_HEIGHT:int = 150;
    private static const WIDTH:int = 474;
    private static const topClass:Class = DeviceBorder_topClass;
    private static const topData:BitmapData = Bitmap(new topClass()).bitmapData;
    private static const centerClass:Class = DeviceBorder_centerClass;
    private static const centerData:BitmapData = Bitmap(new centerClass()).bitmapData;
    private static const bottomClass:Class = DeviceBorder_bottomClass;
    private static const bottomData:BitmapData = Bitmap(new bottomClass()).bitmapData;

    public const top:Shape;
    public const bottom:Shape;
    public const center:Shape;

    public function DeviceBorder(param1:int, param2:Boolean) {
      var local4:Graphics = null;
      this.top = new Shape();
      this.bottom = new Shape();
      this.center = new Shape();
      super();
      var local3:int = Math.max(param1,param2 ? MIN_SINGLE_BUTTON_HEIGHT : MIN_DOUBLE_BUTTON_HEIGHT);
      addChild(this.top);
      addChild(this.center);
      addChild(this.bottom);
      local4 = this.top.graphics;
      local4.clear();
      local4.beginBitmapFill(topData);
      local4.drawRect(0,0,WIDTH,5);
      local4.endFill();
      this.top.x = 0;
      this.top.y = 0;
      local4 = this.center.graphics;
      local4.clear();
      local4.beginBitmapFill(centerData);
      local4.drawRect(0,0,WIDTH,local3 - 10);
      local4.endFill();
      this.center.x = 0;
      this.center.y = 5;
      local4 = this.bottom.graphics;
      local4.clear();
      local4.beginBitmapFill(bottomData);
      local4.drawRect(0,0,WIDTH,5);
      local4.endFill();
      this.bottom.x = 0;
      this.bottom.y = local3 - 5;
    }
  }
}
