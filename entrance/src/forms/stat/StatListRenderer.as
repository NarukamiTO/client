package forms.stat {
  import controls.Money;
  import controls.base.LabelBase;
  import controls.statassets.StatLineBackgroundNormal;
  import controls.statassets.StatLineBackgroundSelected;
  import fl.controls.listClasses.CellRenderer;
  import fl.controls.listClasses.ListData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ranks.SmallRankIcon;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.rank.RankService;

  public class StatListRenderer extends CellRenderer {
    [Inject]
    public static var rankService:RankService;

    protected var nicon:DisplayObject;

    public function StatListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      _data = param1;
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

    protected function bg(param1:Boolean) : DisplayObject {
      return new Sprite();
    }

    protected function myIcon(param1:Object) : Sprite {
      var local2:Sprite = null;
      var local3:LabelBase = null;
      var local6:LabelBase = null;
      var local7:LabelBase = null;
      var local8:int = 0;
      local2 = new Sprite();
      local3 = new LabelBase();
      var local4:SmallRankIcon = new SmallRankIcon(_data.rank);
      var local5:LabelBase = new LabelBase();
      local6 = new LabelBase();
      local3.autoSize = TextFieldAutoSize.NONE;
      local3.align = TextFormatAlign.RIGHT;
      local3.width = 45;
      local3.text = _data.pos < 0 ? " " : _data.pos;
      local2.addChild(local3);
      if(_data.rank > 0) {
        local4.y = 3;
        local4.x = 53;
        local2.addChild(local4);
        local5.text = rankService.getRankName(int(_data.rank));
        local5.x = 63;
        local2.addChild(local5);
      }
      local6.autoSize = TextFieldAutoSize.NONE;
      local6.height = 18;
      local6.text = _data.callsign;
      local6.selectable = true;
      local6.x = 178;
      local6.width = _width - 520;
      local2.addChild(local6);
      local8 = int(_width - 375);
      local7 = new LabelBase();
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.width = 60;
      local7.x = local8;
      local7.text = _data.score > -1 ? Money.numToString(_data.score,false) : " ";
      local2.addChild(local7);
      local8 += 60;
      local7 = new LabelBase();
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.width = 70;
      local7.x = local8;
      local7.text = _data.kills > -1 ? Money.numToString(_data.kills,false) : " ";
      local2.addChild(local7);
      local8 += 70;
      local7 = new LabelBase();
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.width = 50;
      local7.x = local8;
      local7.text = _data.deaths > -1 ? Money.numToString(_data.deaths,false) : " ";
      local2.addChild(local7);
      local8 += 50;
      local7 = new LabelBase();
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.width = 40;
      local7.x = local8;
      local7.text = _data.ratio > -1 ? Money.numToString(_data.ratio) : (_data.ratio == -11 ? " " : "—");
      local2.addChild(local7);
      local8 += 40;
      local7 = new LabelBase();
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.width = 65;
      local7.x = local8;
      local7.htmlText = _data.wealth > -1 ? Money.numToString(_data.wealth,false) : " ";
      local2.addChild(local7);
      local8 += 75;
      local7 = new LabelBase();
      local7.autoSize = TextFieldAutoSize.NONE;
      local7.align = TextFormatAlign.RIGHT;
      local7.width = 69;
      local7.x = local8;
      local7.text = _data.rating > -1 ? Money.numToString(_data.rating) : " ";
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
