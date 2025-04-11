package alternativa.tanks.view.battleinfo.renderer {
  import alternativa.tanks.view.battleinfo.LocaleBattleInfo;
  import controls.base.LabelBase;
  import controls.cellrenderer.ButtonState;
  import controls.cellrenderer.CellNormal;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.TextFormatAlign;
  import fonts.TanksFontService;
  import forms.ColorConstants;
  import forms.Styles;
  import forms.userlabel.UserLabel;

  public class BattleInfoUserListRenderer extends CellRenderer {
    private var format:TextFormat = TanksFontService.getTextFormat(13);
    private var nicon:DisplayObject;
    private var style:ButtonState = new CellNormal();

    public function BattleInfoUserListRenderer() {
      super();
      this.format.color = ColorConstants.WHITE;
      setStyle(Styles.TEXT_FORMAT,this.format);
      setStyle(Styles.EMBED_FONTS,TanksFontService.isEmbedFonts());
    }

    override public function set data(param1:Object) : void {
      var local2:ButtonState = null;
      local2 = this.getCurrentStyle();
      _data = param1;
      mouseChildren = true;
      buttonMode = false;
      useHandCursor = false;
      this.nicon = this.myIcon(_data);
      setStyle(Styles.UP_SKIN,local2);
      setStyle(Styles.DOWN_SKIN,local2);
      setStyle(Styles.OVER_SKIN,local2);
      setStyle(Styles.SELECTED_UP_SKIN,local2);
      setStyle(Styles.SELECTED_OVER_SKIN,local2);
      setStyle(Styles.SELECTED_DOWN_SKIN,local2);
    }

    private function myIcon(param1:Object) : Sprite {
      var local3:UserLabel = null;
      var local4:LabelBase = null;
      var local5:LabelBase = null;
      if(_width < 0) {
        _width = 20;
      }
      var local2:Sprite = new Sprite();
      if(param1.id != null) {
        local3 = new UserLabel(param1.id);
        if(Boolean(param1.suspicious)) {
          local3.setUidColor(ColorConstants.SUSPICIOUS,true);
        } else {
          local3.setUidColor(ColorConstants.WHITE);
        }
        local3.x = -4;
        local3.y = 0;
        local2.addChild(local3);
        local4 = new LabelBase();
        local4.mouseEnabled = false;
        local4.color = ColorConstants.WHITE;
        local4.autoSize = TextFieldAutoSize.NONE;
        local4.align = TextFormatAlign.RIGHT;
        local4.text = param1.score;
        local4.height = 20;
        local4.width = 120;
        local4.x = _width - 135;
        local4.y = 0;
        local2.addChild(local4);
      } else {
        local5 = new LabelBase();
        local5.text = LocaleBattleInfo.noNameText;
        local5.alpha = 0.5;
        local5.x = 10;
        local2.addChild(local5);
      }
      return local2;
    }

    override public function set listData(param1:ListData) : void {
      _listData = param1;
      label = "";
      if(this.nicon != null) {
        setStyle(Styles.ICON,this.nicon);
      }
    }

    override protected function drawLayout() : void {
      super.drawLayout();
      background.width = width - 4;
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

    public function getCurrentStyle() : ButtonState {
      return this.style;
    }
  }
}
