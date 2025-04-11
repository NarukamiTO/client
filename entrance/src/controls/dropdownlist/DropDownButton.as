package controls.dropdownlist {
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;

  public class DropDownButton extends Sprite {
    private var buttonClass:Class = DropDownButton_buttonClass;
    private var buttonUpClass:Class = DropDownButton_buttonUpClass;
    private var back:Bitmap = new this.buttonClass();
    private var backMouseUp:Bitmap = new this.buttonUpClass();

    public function DropDownButton() {
      super();
      addChild(this.back);
      buttonMode = true;
      addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver);
      addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut);
    }

    private function onMouseOver(param1:MouseEvent) : void {
      removeChildren();
      addChild(this.backMouseUp);
    }

    private function onMouseOut(param1:MouseEvent) : void {
      addChild(this.back);
    }
  }
}
