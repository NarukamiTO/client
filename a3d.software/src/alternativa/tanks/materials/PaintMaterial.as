package alternativa.tanks.materials {
  import alternativa.engine3d.materials.TextureMaterial;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  import flash.display.Shape;

  public class PaintMaterial extends TextureMaterial {
    public var scaleX:Number = 1;
    public var scaleY:Number = 1;

    public function PaintMaterial(param1:BitmapData, param2:BitmapData, param3:BitmapData, param4:int = 0) {
      var local5:BitmapData = new BitmapData(param2.width,param2.height);
      var local6:Shape = new Shape();
      local6.graphics.beginBitmapFill(param1);
      local6.graphics.drawRect(0,0,param2.width,param2.height);
      local6.graphics.endFill();
      local5.draw(local6);
      local5.draw(param2,null,null,BlendMode.HARDLIGHT);
      local5.draw(param3);
      super(local5,true,true,param4);
    }
  }
}
