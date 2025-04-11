package alternativa.tanks.gui {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;

  public class UpgradeIndicator extends Sprite {
    private static const m0Class:Class = UpgradeIndicator_m0Class;
    private static const m1Class:Class = UpgradeIndicator_m1Class;
    private static const m2Class:Class = UpgradeIndicator_m2Class;
    private static const m3Class:Class = UpgradeIndicator_m3Class;
    private static const modificationBitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>(4);

    modificationBitmapDatas[0] = new m0Class().bitmapData;
    modificationBitmapDatas[1] = new m1Class().bitmapData;
    modificationBitmapDatas[2] = new m2Class().bitmapData;
    modificationBitmapDatas[3] = new m3Class().bitmapData;

    public function UpgradeIndicator(param1:int) {
      super();
      var local2:Bitmap = new Bitmap(modificationBitmapDatas[param1]);
      addChild(local2);
    }
  }
}
