package controls.buttons {
  import controls.buttons.h30px.H30ButtonSkin;
  import flash.display.Bitmap;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class IconButton extends FixedHeightButton {
    protected var icon:Bitmap;

    public function IconButton(param1:String, param2:Class) {
      super(new CategoryButtonSkin());
      enabled = true;
      labelSize = H30ButtonSkin.DEFAULT_LABEL_SIZE;
      labelHeight = H30ButtonSkin.DEFAULT_LABEL_HEIGHT;
      labelPositionY = H30ButtonSkin.DEFAULT_LABEL_Y;
      _label.align = TextFormatAlign.LEFT;
      _label.autoSize = TextFieldAutoSize.LEFT;
      _label.text = param1;
      this.icon = new param2();
      _innerLayer.addChild(this.icon);
      this.alignIcon();
    }

    override public function set width(param1:Number) : void {
      if(_label.visible) {
        if(Boolean(this.icon) && this.icon.visible) {
          _label.x = 21 + (param1 - 21 - _label.width >> 1);
        } else {
          _label.x = param1 - _label.width >> 1;
        }
      }
      super.width = param1;
    }

    protected function alignIcon() : void {
      this.icon.x = 30 - this.icon.bitmapData.width >> 1;
      this.icon.y = 30 - this.icon.bitmapData.height >> 1;
    }
  }
}
