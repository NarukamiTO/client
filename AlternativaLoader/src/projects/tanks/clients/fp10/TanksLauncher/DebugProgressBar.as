package projects.tanks.clients.fp10.TanksLauncher {
  import flash.display.BlendMode;
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

  public class DebugProgressBar extends Sprite {
    private static const WIDTH:int = 300;
    private static const HEIGHT:int = 30;
    private static const BAR_MARGIN:int = 3;
    private static const BGCOLOR:uint = 3355443;
    private static const FGCOLOR:uint = 16777215;

    public var text:String;

    private var textField:TextField;

    public function DebugProgressBar() {
      super();
      this.textField = new TextField();
      this.textField.defaultTextFormat = new TextFormat("Tahoma",12,16777215);
      this.textField.autoSize = TextFieldAutoSize.LEFT;
      this.textField.x = 10;
      this.textField.y = 5;
      this.textField.blendMode = BlendMode.INVERT;
      addChild(this.textField);
      this.setProgress(0,1);
    }

    public function setProgress(param1:int, param2:int) : void {
      var local3:String = param1 + "/" + param2;
      if(this.text) {
        this.textField.text = this.text + local3;
      } else {
        this.textField.text = local3;
      }
      var local4:int = (WIDTH - 2 * BAR_MARGIN) * param1 / param2;
      var local5:Graphics = graphics;
      local5.lineStyle(1,FGCOLOR);
      local5.beginFill(BGCOLOR);
      local5.drawRect(0,0,WIDTH - 1,HEIGHT - 1);
      local5.lineStyle();
      local5.beginFill(FGCOLOR);
      local5.drawRect(BAR_MARGIN,BAR_MARGIN,local4,HEIGHT - BAR_MARGIN - BAR_MARGIN);
      local5.endFill();
    }

    public function align() : void {
      x = stage.stageWidth - width >> 1;
    }
  }
}
