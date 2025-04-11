package alternativa.tanks.utils {
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.utils.Dictionary;

  public class DebugPanel extends Sprite {
    private var values:Dictionary;
    private var count:int;

    public function DebugPanel() {
      super();
      this.values = new Dictionary();
      mouseEnabled = false;
      tabEnabled = false;
      mouseChildren = false;
      tabChildren = false;
    }

    public function printValue(param1:String, ... rest) : void {
      var local3:TextField = this.values[param1];
      if(local3 == null) {
        local3 = this.createTextField();
        this.values[param1] = local3;
      }
      local3.text = param1 + ": " + rest.join(" ");
    }

    public function printText(param1:String) : void {
      this.createTextField().text = param1;
    }

    private function createTextField() : TextField {
      var local1:TextField = new TextField();
      local1.autoSize = TextFieldAutoSize.LEFT;
      addChild(local1);
      local1.defaultTextFormat = new TextFormat("Tahoma",11,16777215);
      local1.y = this.count * 20;
      ++this.count;
      return local1;
    }
  }
}
