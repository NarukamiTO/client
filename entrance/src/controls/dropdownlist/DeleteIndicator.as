package controls.dropdownlist {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;

  public class DeleteIndicator extends Sprite {
    private static var crossIconClass:Class = DeleteIndicator_crossIconClass;
    private static var crossIconBitmapData:BitmapData = new crossIconClass().bitmapData;

    public var data:Object;

    public function DeleteIndicator(param1:Object) {
      super();
      this.data = param1;
      buttonMode = true;
      tabEnabled = false;
      addEventListener(MouseEvent.CLICK,this.onMouseClick);
      addChild(new Bitmap(crossIconBitmapData));
    }

    private function onMouseClick(param1:MouseEvent) : void {
      visible = false;
      param1.stopPropagation();
      removeEventListener(MouseEvent.CLICK,this.onMouseClick);
      dispatchEvent(new DeleteEvent(this.data));
    }
  }
}
