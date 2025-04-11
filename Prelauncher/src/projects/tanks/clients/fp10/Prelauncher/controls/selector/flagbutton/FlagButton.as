package projects.tanks.clients.fp10.Prelauncher.controls.selector.flagbutton {
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.selector.LocaleSelectionEvent;

  public class FlagButton extends Sprite {
    public var locale:Locale;

    private var _selectorItem:Boolean = false;

    public function FlagButton(bmpData:BitmapData, locale:Locale) {
      super();
      this.locale = locale;
      var shape:Shape = new Shape();
      shape.graphics.clear();
      shape.graphics.beginBitmapFill(bmpData);
      shape.graphics.drawRect(0,0,bmpData.width,bmpData.height);
      shape.graphics.endFill();
      addChild(shape);
      addEventListener(MouseEvent.CLICK,this.click);
      addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
      addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
      this.redraw(false);
    }

    public function redraw(mouseOver:Boolean) : void {
      graphics.clear();
      if(this.selectorItem) {
        return;
      }
      graphics.beginFill(0,0);
      graphics.drawRect(-8,-5,66,26);
      graphics.endFill();
      if(!mouseOver) {
        return;
      }
      graphics.beginFill(0,1);
      graphics.drawRect(-8,-5,66,26);
      graphics.endFill();
    }

    public function set selectorItem(value:Boolean) : void {
      this._selectorItem = value;
    }

    public function get selectorItem() : Boolean {
      return this._selectorItem;
    }

    private function click(e:MouseEvent) : void {
      var ev:LocaleSelectionEvent = new LocaleSelectionEvent(LocaleSelectionEvent.SELECTION,true,false);
      ev.locale = this.locale;
      dispatchEvent(ev);
    }

    private function onMouseOver(e:MouseEvent) : void {
      if(!this.selectorItem) {
        Mouse.cursor = MouseCursor.BUTTON;
      }
      this.redraw(true);
    }

    private function onMouseOut(e:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
      this.redraw(false);
    }
  }
}
