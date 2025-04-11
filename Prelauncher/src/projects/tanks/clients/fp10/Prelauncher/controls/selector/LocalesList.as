package projects.tanks.clients.fp10.Prelauncher.controls.selector {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.LocalesFactory;
  import projects.tanks.clients.fp10.Prelauncher.controls.selector.flagbutton.FlagButton;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;

  public class LocalesList extends Sprite {
    private static var flagsPng:Class = LocalesList_flagsPng;
    private static var flagsBitmapData:BitmapData = (new flagsPng() as Bitmap).bitmapData;
    private static var panel:Class = LocalesList_panel;
    private static var panelData:BitmapData = (new panel() as Bitmap).bitmapData;

    public var flags:Vector.<FlagButton> = new Vector.<FlagButton>();

    private var _panel:Shape;

    public function LocalesList() {
      super();
      this.y = panelData.height + 27;
      this.x = 4;
      this._panel = new Shape();
      this.drawPanel();
      this.createFlags();
      addEventListener(LocaleSelectionEvent.SELECTION,this.localeSelected);
    }

    private function drawPanel() : void {
      var top:Number = NaN;
      var j:int = 0;
      var rect:Rectangle = new Rectangle(9,9,1,1);
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
      this._panel.scaleX = 70 / panelData.width;
      this._panel.scaleY = (Locales.list.length - 1) * 28 / panelData.height;
    }

    public function createFlags() : void {
      var size:Point = null;
      var bmpData:BitmapData = null;
      var fb:FlagButton = null;
      var locales:Array = Locales.list;
      for(var i:int = 0; i < locales.length; i++) {
        size = new Point(flagsBitmapData.width / locales.length,flagsBitmapData.height);
        bmpData = new BitmapData(size.x,size.y);
        bmpData.copyPixels(flagsBitmapData,new Rectangle(size.x * i,0,size.x,size.y),new Point(0,0));
        fb = new FlagButton(bmpData,LocalesFactory.getLocale(locales[i]));
        this.flags.push(fb);
      }
    }

    public function addFlags() : void {
      var fb:FlagButton = null;
      addChild(this._panel);
      var j:int = 0;
      for(var i:int = 0; i < this.flags.length; i++) {
        fb = this.flags[i];
        if(fb.locale != Locale.current) {
          fb.x = 10;
          fb.y = 26 * j + 11;
          fb.selectorItem = false;
          fb.redraw(false);
          addChild(fb);
          j++;
        }
      }
    }

    private function localeSelected(e:LocaleSelectionEvent) : void {
      removeChildren();
    }
  }
}
