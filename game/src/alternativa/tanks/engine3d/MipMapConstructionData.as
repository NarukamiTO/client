package alternativa.tanks.engine3d {
  import flash.display.BitmapData;
  import flash.geom.Rectangle;

  internal class MipMapConstructionData {
    public var w:Number = 0;
    public var h:Number = 0;
    public var rect:Rectangle = new Rectangle();
    public var tmpBitmapData:BitmapData;

    public function MipMapConstructionData() {
      super();
    }

    public function setInitialSize(param1:int, param2:int) : void {
      this.w = param1;
      this.h = param2;
      this.rect.width = param1;
      this.rect.height = param2;
    }
  }
}
