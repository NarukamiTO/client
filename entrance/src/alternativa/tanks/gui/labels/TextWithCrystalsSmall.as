package alternativa.tanks.gui.labels {
  import alternativa.tanks.gui.icons.CrystalIcon;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;

  public class TextWithCrystalsSmall extends Sprite {
    public var label:LabelBase;

    public function TextWithCrystalsSmall(param1:String) {
      super();
      mouseEnabled = false;
      mouseChildren = false;
      this.label = new LabelBase();
      this.label.color = 4772391;
      this.label.size = 16;
      this.label.bold = true;
      this.label.text = param1;
      addChild(this.label);
      var local2:Bitmap = CrystalIcon.createSmallInstance();
      local2.x = this.label.width + 1;
      local2.y = 5;
      addChild(local2);
    }
  }
}
