package alternativa.tanks.view.battlelist.forms {
  import controls.base.LabelBase;
  import controls.statassets.BlackRoundRect;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;

  public class ProBattlePassAlert extends Sprite {
    private static const proBattlePassClass:Class = ProBattlePassAlert_proBattlePassClass;
    private static const proBattlePassClassBitmapData:BitmapData = new proBattlePassClass().bitmapData;

    private var bg:BlackRoundRect;
    private var label:LabelBase;

    public function ProBattlePassAlert(param1:String) {
      super();
      this.bg = new BlackRoundRect();
      this.bg.height = 69;
      addChild(this.bg);
      var local2:Bitmap = new Bitmap(proBattlePassClassBitmapData);
      addChild(local2);
      local2.x = 12;
      local2.y = 10;
      this.label = new LabelBase();
      this.label.text = param1;
      this.label.x = 100;
      this.label.multiline = true;
      this.label.wordWrap = true;
      addChild(this.label);
    }

    override public function set width(param1:Number) : void {
      this.bg.width = param1;
      this.label.width = param1 - 112;
      this.label.y = 70 - this.label.height >> 1;
    }

    override public function set height(param1:Number) : void {
    }
  }
}
