package controls.caprefbutton {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;

  public class CapRefButton extends Sprite {
    private static const bitmapBG:Class = CapRefButton_bitmapBG;
    private static const bgBMP:BitmapData = new bitmapBG().bitmapData;

    private var bmp:Bitmap = new Bitmap(bgBMP);

    public function CapRefButton() {
      super();
      addChild(this.bmp);
      addEventListener(MouseEvent.MOUSE_DOWN,this.mouseHandler);
      addEventListener(MouseEvent.MOUSE_UP,this.mouseHandler);
    }

    private function mouseHandler(param1:MouseEvent) : void {
      this.bmp.y = param1.type == MouseEvent.MOUSE_DOWN ? 1 : 0;
    }
  }
}
