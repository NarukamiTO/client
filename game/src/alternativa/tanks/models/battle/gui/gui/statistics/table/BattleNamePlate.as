package alternativa.tanks.models.battle.gui.gui.statistics.table {
  import controls.Label;
  import controls.statassets.BlackRoundRect;

  public class BattleNamePlate extends BlackRoundRect {
    private static const FONT_SIZE:int = 18;
    private static const PADDING:int = 3;

    private var label:Label;

    public function BattleNamePlate(param1:String) {
      super();
      this.label = new Label();
      this.label.size = FONT_SIZE;
      this.label.text = param1;
      addChild(this.label);
      this.label.y = PADDING;
      height = 2 * PADDING + this.label.height;
    }

    public function setBattleName(param1:String) : * {
      this.label.text = param1;
      this.updateLabelPosition();
    }

    [Obfuscation(rename="false")]
    override public function set width(param1:Number) : void {
      super.width = param1;
      this.updateLabelPosition();
    }

    private function updateLabelPosition() : void {
      this.label.x = int(width - this.label.width) >> 1;
    }
  }
}
