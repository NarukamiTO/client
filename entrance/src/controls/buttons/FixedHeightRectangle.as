package controls.buttons {
  import base.DiscreteSprite;
  import flash.display.Bitmap;

  public class FixedHeightRectangle extends DiscreteSprite {
    private var left:Bitmap;
    private var middle:Bitmap;
    private var right:Bitmap;

    public function FixedHeightRectangle(param1:FixedHeightRectangleSkin) {
      super();
      this.left = new Bitmap(param1.left);
      this.middle = new Bitmap(param1.middle);
      this.right = new Bitmap(param1.right);
      this.setSkin(param1);
      addChild(this.left);
      addChild(this.right);
      addChild(this.middle);
      mouseEnabled = false;
    }

    public function setSkin(param1:FixedHeightRectangleSkin) : void {
      this.left.bitmapData = param1.left;
      this.middle.bitmapData = param1.middle;
      this.right.bitmapData = param1.right;
      this.align(width);
    }

    override public function set width(param1:Number) : void {
      param1 = int(param1);
      this.align(param1);
      super.width = param1;
    }

    private function align(param1:int) : void {
      this.middle.x = this.left.width;
      this.right.x = param1 - this.right.width;
      this.middle.width = param1 - this.left.width - this.right.width;
    }
  }
}
