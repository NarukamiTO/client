package controls.dropdownlist {
  import assets.combo.ComboListOverState;
  import controls.base.LabelBase;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;

  public class ComboBoxRenderer extends CellRenderer {
    private var nicon:DisplayObject;
    private var normalStyle:Bitmap;
    private var overStyle:ComboListOverState = new ComboListOverState();

    public function ComboBoxRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      this.normalStyle = new Bitmap(new BitmapData(1,1,true,0));
      _data = param1;
      setStyle("upSkin",this.normalStyle);
      setStyle("downSkin",this.overStyle);
      setStyle("overSkin",this.overStyle);
      setStyle("selectedUpSkin",this.normalStyle);
      setStyle("selectedOverSkin",this.overStyle);
      setStyle("selectedDownSkin",this.overStyle);
    }

    protected function myIcon(param1:Object) : Sprite {
      var local2:Sprite = null;
      var local3:LabelBase = null;
      local2 = new Sprite();
      local3 = new LabelBase();
      local3.autoSize = TextFieldAutoSize.NONE;
      local3.color = 16777215;
      local3.alpha = 1;
      local3.text = param1.gameName;
      local3.height = 20;
      local3.width = _width - 20;
      local3.x = -3;
      local3.y = 0;
      local2.addChild(local3);
      return local2;
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = "";
      this.nicon = this.myIcon(_data);
      if(this.nicon != null) {
        setStyle("icon",this.nicon);
      }
    }

    override protected function drawLayout() : void {
      super.drawLayout();
      background.width = width - 6;
      background.height = height;
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
