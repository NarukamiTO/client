package alternativa.tanks.gui.notinclan.clanslist {
  import base.DiscreteSprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class AcceptIndicator extends DiscreteSprite {
    private static var iconClass:Class = AcceptIndicator_iconClass;
    private static var iconBitmapData:BitmapData = Bitmap(new iconClass()).bitmapData;

    public function AcceptIndicator() {
      super();
      this.tabChildren = false;
      this.tabEnabled = false;
      this.buttonMode = this.useHandCursor = true;
      var local1:Bitmap = new Bitmap(iconBitmapData);
      addChild(local1);
    }
  }
}
