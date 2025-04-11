package controls.dropdownlist {
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;

  public class AccountsRenderer extends ComboR {
    private static var overStyleClass:Class = AccountsRenderer_overStyleClass;
    private static var overStyleBitmapData:BitmapData = new overStyleClass().bitmapData;

    public function AccountsRenderer() {
      super();
    }

    override protected function myIcon(param1:Object) : Sprite {
      var local3:LabelBase = null;
      var local2:Sprite = new Sprite();
      local3 = new LabelBase();
      local3.autoSize = TextFieldAutoSize.NONE;
      local3.color = 16777215;
      local3.alpha = param1.rang > 0 ? 0.5 : 1;
      local3.text = param1.gameName;
      local3.height = AccountsList.ROW_HEIGHT;
      local3.width = _width - 20;
      local3.x -= 5;
      local2.addChild(local3);
      var local4:DeleteIndicator = new DeleteIndicator(param1);
      local4.x = local2.width - local4.width + 5;
      local2.addChild(local4);
      tabEnabled = false;
      mouseEnabled = false;
      mouseChildren = true;
      return local2;
    }

    override public function set data(param1:Object) : void {
      var local2:Bitmap = new Bitmap(new BitmapData(1,1,true,0));
      var local3:Shape = new Shape();
      local3.graphics.beginBitmapFill(overStyleBitmapData);
      local3.graphics.drawRect(0,0,1,18);
      local3.graphics.endFill();
      _data = param1;
      setStyle("upSkin",local2);
      setStyle("downSkin",local3);
      setStyle("overSkin",local3);
      setStyle("selectedUpSkin",local2);
      setStyle("selectedOverSkin",local3);
      setStyle("selectedDownSkin",local3);
    }
  }
}
