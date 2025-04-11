package alternativa.tanks.gui.components.rank {
  import controls.dropdownlist.ComboBoxRenderer;
  import flash.display.Sprite;
  import forms.ranks.SmallRankIcon;

  public class RanksRenderer extends ComboBoxRenderer {
    public function RanksRenderer() {
      super();
    }

    override protected function myIcon(param1:Object) : Sprite {
      var local2:Sprite = new Sprite();
      var local3:SmallRankIcon = new SmallRankIcon();
      local3.init(false,param1.rank);
      local2.addChild(local3);
      return local2;
    }
  }
}
