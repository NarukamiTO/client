package projects.tanks.clients.fp10.Prelauncher.controls.buttons {
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.TextLineMetrics;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class Button extends LocalizedControl {
    private var onClick:Function;

    protected var textField:TextField = new TextField();

    public function Button(onClick:Function) {
      super();
      this.onClick = onClick;
      this.scaleX = 0.71;
      this.scaleY = this.scaleX;
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }

    private function addedToStage(e:Event) : void {
      removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
      var textFormat:TextFormat = new TextFormat();
      textFormat.size = 32;
      textFormat.bold = true;
      textFormat.font = MakeUp.getFont(Locale.current);
      this.textField.embedFonts = Locale.current.name != Locales.CN;
      this.textField.defaultTextFormat = textFormat;
      this.textField.autoSize = TextFieldAutoSize.CENTER;
      this.textField.wordWrap = false;
      this.textField.multiline = false;
      this.textField.selectable = false;
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
      addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
      addEventListener(MouseEvent.CLICK,this.onMouseClick);
    }

    private function removedFromStage(e:Event) : void {
      removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
    }

    protected function textFieldToCenter() : void {
      var metrics:TextLineMetrics = this.textField.getLineMetrics(0);
      this.textField.x = -metrics.width >> 1;
      this.textField.y = (-metrics.height >> 1) - 4;
    }

    private function onMouseOver(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.BUTTON;
      getChildAt(0).visible = false;
      getChildAt(1).visible = true;
    }

    private function onMouseOut(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
      getChildAt(0).visible = true;
      getChildAt(1).visible = false;
    }

    private function onMouseDown(e:MouseEvent) : void {
      getChildAt(0).visible = true;
      getChildAt(1).visible = false;
    }

    private function onMouseUp(e:MouseEvent) : void {
      getChildAt(0).visible = false;
      getChildAt(1).visible = true;
    }

    private function onMouseClick(e:MouseEvent) : void {
      this.onClick.call(this,e);
    }
  }
}
