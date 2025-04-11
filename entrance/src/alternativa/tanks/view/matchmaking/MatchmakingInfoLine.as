package alternativa.tanks.view.matchmaking {
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class MatchmakingInfoLine extends Sprite {
    private static const WIDTH:int = 300;

    private var dataLabel:LabelBase;

    public function MatchmakingInfoLine(param1:String) {
      super();
      addChild(this.createLabel(param1));
      this.dataLabel = this.createLabel();
      addChild(this.dataLabel);
      this.dataLabel.x = WIDTH - this.dataLabel.width;
    }

    private function createLabel(param1:String = "") : LabelBase {
      var local2:LabelBase = new LabelBase();
      local2.autoSize = TextFieldAutoSize.LEFT;
      local2.wordWrap = false;
      local2.multiline = true;
      local2.align = TextFormatAlign.LEFT;
      local2.text = param1;
      local2.size = 12;
      local2.color = 5898034;
      return local2;
    }

    public function setText(param1:String) : void {
      this.dataLabel.text = param1;
      this.dataLabel.x = WIDTH - this.dataLabel.width;
    }
  }
}
