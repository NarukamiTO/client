package alternativa.tanks.gui.icons {
  import base.DiscreteSprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  public class AcceptedIndicator extends DiscreteSprite {
    private static var acceptedIconClass:Class = AcceptedIndicator_acceptedIconClass;
    private static var acceptedIconBitmapData:BitmapData = Bitmap(new acceptedIconClass()).bitmapData;

    public function AcceptedIndicator() {
      super();
      this.tabEnabled = this.tabChildren = false;
      this.buttonMode = this.useHandCursor = true;
      addChild(new Bitmap(acceptedIconBitmapData));
    }
  }
}
