package alternativa.tanks.gui.components.flag {
  import controls.dropdownlist.ComboBoxRenderer;
  import flash.display.Bitmap;
  import flash.display.Sprite;

  public class FlagsRenderer extends ComboBoxRenderer {
    public function FlagsRenderer() {
      super();
    }

    override protected function myIcon(param1:Object) : Sprite {
      var local2:Sprite = new Sprite();
      var local3:Bitmap = Flag.getFlag(param1.country);
      local2.addChild(local3);
      return local2;
    }
  }
}
