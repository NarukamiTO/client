package controls.dropdownlist {
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import forms.ranks.SmallRankIcon;

  public class ComboR extends ComboBoxRenderer {
    public function ComboR() {
      super();
    }

    override protected function myIcon(param1:Object) : Sprite {
      var local3:LabelBase = null;
      var local4:SmallRankIcon = null;
      var local2:Sprite = new Sprite();
      local3 = new LabelBase();
      local3.autoSize = TextFieldAutoSize.NONE;
      local3.color = 16777215;
      local3.alpha = param1.rang > 0 ? 0.5 : 1;
      local3.text = param1.gameName;
      local3.height = 20;
      local3.width = _width - 20;
      local3.y = 0;
      if(param1.rang > 0) {
        local4 = new SmallRankIcon(param1.rang);
        local4.x = -2;
        local4.y = 2;
        local2.addChild(local4);
        local3.x = 12;
      } else {
        local3.x = -3;
      }
      local2.addChild(local3);
      return local2;
    }
  }
}
