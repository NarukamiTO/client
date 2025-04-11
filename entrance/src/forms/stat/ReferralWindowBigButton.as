package forms.stat {
  import controls.base.BigButtonBase;
  import controls.buttons.ButtonStates;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class ReferralWindowBigButton extends BigButtonBase {
    private static const bitmapGreen:Class = ReferralWindowBigButton_bitmapGreen;
    private static const green:BitmapData = new bitmapGreen().bitmapData;

    private var labelY:int;

    public function ReferralWindowBigButton() {
      super();
      _label.size = 12;
      _label.color = 52238;
      _label.multiline = true;
      _label.align = TextFormatAlign.LEFT;
      _label.autoSize = TextFieldAutoSize.LEFT;
      _label.wordWrap = true;
      this.width = 156;
      var local1:Bitmap = new Bitmap(green);
      local1.x = local1.y = 7;
      addChildAt(local1,getChildIndex(_innerLayer));
    }

    override public function set label(param1:String) : void {
      super.label = param1;
      this.labelY = 24 - _label.textHeight / 2;
      this.width = _width;
    }

    override public function set width(param1:Number) : void {
      super.width = param1;
      if(_icon.bitmapData != null) {
        _icon.x = 12;
        _icon.y = int(27 - _icon.height / 2);
        _label.width = _width - 8 - _icon.width;
        _label.x = _icon.width + 14;
        _label.y = this.labelY;
      }
    }

    override protected function onStateChanged() : void {
      super.onStateChanged();
      var local1:int = 0;
      if(getState() == ButtonStates.DOWN) {
        local1 = 1;
      }
      _label.y = this.labelY + local1;
      if(_icon != null) {
        _icon.y = int(27 - _icon.height / 2) + local1;
      }
    }
  }
}
