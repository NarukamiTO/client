package projects.tanks.clients.fp10.Prelauncher.controls.selector {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;
  import projects.tanks.clients.fp10.Prelauncher.controls.selector.flagbutton.FlagButton;
  import projects.tanks.clients.fp10.Prelauncher.makeup.MakeUp;

  public class LocalizationSelector extends LocalizedControl {
    private static var panel:Class = LocalizationSelector_panel;
    private static var panelData:BitmapData = (new panel() as Bitmap).bitmapData;
    private static var WIDTH:Number = 78;
    private static var HEIGHT:Number = 48;

    private var _localesList:LocalesList;
    private var _flag:FlagButton;
    private var _triangle:Bitmap;
    private var _triangleGreen:Bitmap;
    private var _panel:Shape;

    public function LocalizationSelector() {
      super();
      this._panel = new Shape();
      this._triangle = MakeUp.getDropMakeUp();
      this._triangleGreen = MakeUp.getDropGreenMakeUp();
      this._triangle.x = 47;
      this._triangle.y = 18;
      this._triangleGreen.x = this._triangle.x;
      this._triangleGreen.y = this._triangle.y;
      this.createEvents();
    }

    private function createEvents() : void {
      addEventListener(LocaleSelectionEvent.SELECTION,this.addFlag);
      addEventListener(MouseEvent.CLICK,this.click);
      addEventListener(MouseEvent.MOUSE_OVER,function(e:MouseEvent):void {
        Mouse.cursor = MouseCursor.BUTTON;
      });
      addEventListener(MouseEvent.MOUSE_OUT,function(e:MouseEvent):void {
        Mouse.cursor = MouseCursor.AUTO;
      });
    }

    override protected function onResize(e:Event) : void {
      this.x = stage.stageWidth - WIDTH - 7;
      this.y = 3;
      this.drawPanel();
      addChild(this._panel);
      addChild(this._triangle);
      this.addFlag();
    }

    private function drawPanel() : void {
      var top:Number = NaN;
      var j:int = 0;
      var rect:Rectangle = new Rectangle(9,9,26,26);
      var gridX:Array = [rect.left,rect.right,panelData.width];
      var gridY:Array = [rect.top,rect.bottom,panelData.height];
      this._panel.graphics.clear();
      var left:Number = 0;
      for(var i:int = 0; i < 3; i++) {
        top = 0;
        for(j = 0; j < 3; j++) {
          this._panel.graphics.beginBitmapFill(panelData);
          this._panel.graphics.drawRect(left,top,gridX[i] - left,gridY[j] - top);
          this._panel.graphics.endFill();
          top = Number(gridY[j]);
        }
        left = Number(gridX[i]);
      }
      this._panel.scale9Grid = rect;
      this._panel.scaleX = WIDTH / panelData.width;
      this._panel.scaleY = HEIGHT / panelData.height;
    }

    public function closeList() : void {
      this.removeChildren();
      addChild(this._panel);
      addChild(this._flag);
      addChild(this._triangle);
    }

    private function click(e:MouseEvent) : void {
      if(this.numChildren > 3) {
        this.closeList();
      } else {
        addChild(this._triangleGreen);
        this.localesList.addFlags();
        this.addChild(this.localesList);
      }
    }

    private function get localesList() : LocalesList {
      if(this._localesList == null) {
        this._localesList = new LocalesList();
      }
      return this._localesList;
    }

    private function addFlag(e:LocaleSelectionEvent = null) : void {
      var flag:FlagButton = null;
      var locale:Locale = null;
      for each(flag in this.localesList.flags) {
        locale = e == null ? Locale.current : e.locale;
        if(flag.locale == locale) {
          this._flag = flag;
          this._flag.x = 14;
          this._flag.y = 15;
          this._flag.selectorItem = true;
          this._flag.redraw(false);
          addChild(flag);
          break;
        }
      }
    }
  }
}
