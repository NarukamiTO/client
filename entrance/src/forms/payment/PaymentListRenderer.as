package forms.payment {
  import controls.base.LabelBase;
  import controls.statassets.StatLineBackgroundNormal;
  import controls.statassets.StatLineBackgroundSelected;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import utils.TextUtils;

  public class PaymentListRenderer extends CellRenderer {
    private static var _withSMSText:Boolean = false;

    private var nicon:DisplayObject;

    public function PaymentListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
      _withSMSText = _data.smsText !== "";
      var local2:DisplayObject = new StatLineBackgroundNormal();
      var local3:DisplayObject = new StatLineBackgroundSelected();
      this.nicon = this.myIcon(_data);
      setStyle("upSkin",local2);
      setStyle("downSkin",local2);
      setStyle("overSkin",local2);
      setStyle("selectedUpSkin",local3);
      setStyle("selectedOverSkin",local3);
      setStyle("selectedDownSkin",local3);
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = _listData.label;
      if(this.nicon != null) {
        setStyle("icon",this.nicon);
      }
    }

    private function myIcon(param1:Object) : Sprite {
      var local2:Sprite = null;
      var local3:LabelBase = null;
      var local4:LabelBase = null;
      var local5:Bitmap = null;
      var local6:LabelBase = null;
      var local8:int = 0;
      local2 = new Sprite();
      local3 = new LabelBase();
      local4 = new LabelBase();
      local5 = new Bitmap();
      local6 = new LabelBase();
      var local7:LabelBase = new LabelBase();
      local8 = _withSMSText ? 80 : int((_width - 72) / 2);
      local3.autoSize = TextFieldAutoSize.NONE;
      local3.align = TextFormatAlign.CENTER;
      local3.size = 13;
      local3.height = 20;
      local3.x = -5;
      local3.width = 70;
      local3.text = _data.number;
      local2.addChild(local3);
      local6.autoSize = TextFieldAutoSize.NONE;
      local6.align = TextFormatAlign.RIGHT;
      local6.size = 13;
      local6.height = 20;
      local6.text = _data.cost;
      local6.x = 72;
      local6.width = int(local8) - 7;
      local2.addChild(local6);
      if(_withSMSText) {
        local4.autoSize = TextFieldAutoSize.NONE;
        local4.align = TextFormatAlign.LEFT;
        local4.size = 12;
        local4.height = 20;
        local5.x = 72;
        local4.width = _width - 210;
        local4.text = _data.smsText;
        local5.bitmapData = TextUtils.getTextInCells(local4,12,18,5898034);
        local2.addChild(local5);
        local6.x = local4.width + 74;
      }
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.size = 13;
      local7.height = 20;
      local7.x = local6.x + local6.width + 2;
      local7.width = int(_width - local7.x - 12);
      local7.text = _data.crystals;
      local2.addChild(local7);
      return local2;
    }

    override protected function drawBackground() : void {
      var local1:String = enabled ? mouseState : "disabled";
      if(selected) {
        local1 = "selected" + local1.substr(0,1).toUpperCase() + local1.substr(1);
      }
      local1 += "Skin";
      var local2:DisplayObject = background;
      background = getDisplayObjectInstance(getStyleValue(local1));
      addChildAt(background,0);
      if(local2 != null && local2 != background) {
        removeChild(local2);
      }
    }

    override protected function drawLayout() : void {
      super.drawLayout();
    }

    override protected function drawIcon() : void {
      var local1:DisplayObject = icon;
      var local2:String = enabled ? mouseState : "disabled";
      if(selected) {
        local2 = "selected" + local2.substr(0,1).toUpperCase() + local2.substr(1);
      }
      local2 += "Icon";
      var local3:Object = getStyleValue(local2);
      if(local3 == null) {
        local3 = getStyleValue("icon");
      }
      if(local3 != null) {
        icon = getDisplayObjectInstance(local3);
      }
      if(icon != null) {
        addChildAt(icon,1);
      }
      if(local1 != null && local1 != icon && local1.parent == this) {
        removeChild(local1);
      }
    }
  }
}
