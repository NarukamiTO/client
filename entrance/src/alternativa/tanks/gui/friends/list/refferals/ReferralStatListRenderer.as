package alternativa.tanks.gui.friends.list.refferals {
  import controls.Money;
  import controls.base.LabelBase;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.ColorConstants;
  import forms.stat.StatListRenderer;
  import forms.userlabel.UserLabel;

  public class ReferralStatListRenderer extends StatListRenderer {
    private var userLabel:UserLabel;

    public function ReferralStatListRenderer() {
      super();
    }

    override public function set data(param1:Object) : void {
      var local2:DisplayObject = null;
      var local3:DisplayObject = null;
      _data = param1;
      local2 = new ReferralStatLineBackgroundNormal();
      local3 = new ReferalStatLineBackgroundSelected();
      this.mouseChildren = true;
      this.buttonMode = this.useHandCursor = false;
      nicon = this.myIcon(_data);
      _data.uid = this.userLabel.uid;
      setStyle("upSkin",local2);
      setStyle("downSkin",local2);
      setStyle("overSkin",local2);
      setStyle("selectedUpSkin",local3);
      setStyle("selectedOverSkin",local3);
      setStyle("selectedDownSkin",local3);
    }

    override protected function myIcon(param1:Object) : Sprite {
      var local2:Sprite = new Sprite();
      this.userLabel = new UserLabel(param1.userId);
      this.userLabel.inviteBattleEnable = true;
      this.userLabel.setUidColor(ColorConstants.WHITE);
      this.userLabel.x = -3;
      this.userLabel.y = -1;
      local2.addChild(this.userLabel);
      var local3:LabelBase = new LabelBase();
      local3.autoSize = TextFieldAutoSize.NONE;
      local3.align = TextFormatAlign.RIGHT;
      local3.width = 90;
      local3.x = _width - 100;
      local3.text = param1.income > -1 ? Money.numToString(param1.income,false) : "null";
      local3.y = -1;
      local2.addChild(local3);
      return local2;
    }
  }
}
