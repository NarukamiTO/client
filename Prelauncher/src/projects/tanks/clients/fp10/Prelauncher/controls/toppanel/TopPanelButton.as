package projects.tanks.clients.fp10.Prelauncher.controls.toppanel {
  import flash.display.DisplayObject;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.TextLineMetrics;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import flashx.textLayout.formats.TextAlign;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class TopPanelButton extends LocalizedControl {
    public static const GAME:String = "game";
    public static const MATERIALS:String = "materials";
    public static const TOURNAMENTS:String = "tournaments";
    public static const FORUM:String = "forum";
    public static const WIKI:String = "wiki";
    public static const RATINGS:String = "ratings";
    public static const HELP:String = "help";

    public var BUTTON_WIDTH:int = 125;

    private var textField:TextField;
    private var type:String;

    public function TopPanelButton(type:String) {
      super();
      this.type = type;
      this.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
      this.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
      this.addEventListener(MouseEvent.CLICK,this.mouseClick);
      this.redraw();
    }

    private function redraw() : void {
      graphics.clear();
      graphics.lineStyle(0,0,0);
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,this.BUTTON_WIDTH,TopPanel.topLineData.height);
      graphics.endFill();
    }

    private function mouseClick(e:MouseEvent) : void {
      navigateToURL(new URLRequest(Locale.current[this.type].link));
    }

    override public function switchLocale(locale:Locale) : void {
      removeChildren();
      if(locale[this.type] == null) {
        this.BUTTON_WIDTH = 0;
        return;
      }
      var tf:TextFormat = new TextFormat();
      tf.align = TextAlign.CENTER;
      tf.font = MakeUp.getFont(locale);
      tf.bold = true;
      tf.size = 14;
      var icon:DisplayObject = MakeUp.getIconMakeUp(this.type);
      this.verticalCenter(icon);
      var obj:DisplayObject = MakeUp.getActiveIconMakeUp(this.type);
      obj.visible = false;
      this.verticalCenter(obj);
      this.textField = new TextField();
      this.textField.autoSize = TextFieldAutoSize.RIGHT;
      this.textField.embedFonts = locale.name != Locales.CN;
      this.textField.defaultTextFormat = tf;
      this.textField.selectable = false;
      this.textField.textColor = 16777215;
      this.textField.text = locale[this.type].text;
      var metrics:TextLineMetrics = this.textField.getLineMetrics(0);
      this.BUTTON_WIDTH = metrics.width + icon.width + 30;
      this.textField.y = 50 - metrics.height >> 1;
      this.textField.x = 0;
      this.textField.width = this.BUTTON_WIDTH;
      this.textField.height = TopPanel.topLineData.height;
      icon.x = 15;
      obj.x = 15;
      addChild(this.textField);
      addChild(icon);
      addChild(obj);
      graphics.clear();
      graphics.lineStyle(0,16711680,0);
      graphics.beginFill(0,0);
      graphics.drawRect(0,0,this.BUTTON_WIDTH,TopPanel.topLineData.height);
      graphics.endFill();
    }

    private function mouseOut(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
      if(numChildren > 0) {
        this.textField.textColor = 16777215;
        getChildAt(1).visible = true;
        getChildAt(numChildren - 1).visible = false;
      }
    }

    private function mouseOver(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.BUTTON;
      if(numChildren > 0) {
        this.textField.textColor = 65280;
        getChildAt(1).visible = false;
        getChildAt(numChildren - 1).visible = true;
      }
    }

    private function verticalCenter(obj:DisplayObject) : void {
      obj.y = 50 - obj.height >> 1;
    }
  }
}
