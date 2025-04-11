package alternativa.tanks.gui.payment.controls {
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;

  public class OrderingLine extends Sprite {
    protected var _width:Number;
    protected var descriptionLabel:LabelBase;
    protected var crystalsLabel:LabelBase;

    public function OrderingLine(param1:int, param2:String, param3:int) {
      super();
      this.descriptionLabel = this.createLabel(param2);
      addChild(this.descriptionLabel);
      this.crystalsLabel = this.createLabel(param3.toString());
      addChild(this.crystalsLabel);
      this.crystalsLabel.x = param1 - this.crystalsLabel.width;
    }

    private function createLabel(param1:String) : LabelBase {
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
  }
}
