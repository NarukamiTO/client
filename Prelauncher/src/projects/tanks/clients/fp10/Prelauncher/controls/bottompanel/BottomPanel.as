package projects.tanks.clients.fp10.Prelauncher.controls.bottompanel {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Shape;
  import flash.events.Event;
  import flash.geom.Rectangle;
  import projects.tanks.clients.fp10.Prelauncher.Locale;
  import projects.tanks.clients.fp10.Prelauncher.controls.LocalizedControl;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.LinkField.LinkField;
  import projects.tanks.clients.fp10.Prelauncher.controls.bottompanel.PartnerLogo.PartnerLogo;
  import projects.tanks.clients.fp10.Prelauncher.locales.CN.LocaleCN;
  import projects.tanks.clients.fp10.Prelauncher.locales.Locales;

  public class BottomPanel extends LocalizedControl {
    private static var bottomLine:Class = BottomPanel_bottomLine;

    public static var bottomLineData:BitmapData = (new bottomLine() as Bitmap).bitmapData;
    public static var bottomPanelHeight:int = 100;

    private static var panel:Shape = new Shape();

    private const rectangle:Rectangle = new Rectangle(9,9,1,1);

    public function BottomPanel() {
      super();
    }

    public function createLines(locale:Locale) : void {
      this.addPartners(locale);
      if(locale.name == Locales.CN) {
        this.createChineseLines(locale as LocaleCN);
        return;
      }
      this.addLine(10,10,5,locale,LinkField.ABOUT);
      this.addLine(10,58,15,locale,LinkField.LICENSE,LinkField.RULES,LinkField.CONFIDENT);
    }

    private function createChineseLines(locale:LocaleCN) : void {
      this.addLine(10,4,5,locale,"chinese1","chinese2");
      this.addLine(10,20,5,locale,"chinese3");
      this.addLine(10,36,5,locale,"chinese4");
      this.addLine(10,52,5,locale,"chinese5");
      this.addLine(10,68,5,locale,"chinese6");
      this.addLine(10,84,5,locale,"chinese7");
      this.addLine(400,4,5,locale,"chinese21");
      this.addLine(400,20,5,locale,"chinese22");
      this.addLine(400,36,5,locale,"chinese23");
      this.addLine(400,52,5,locale,"chinese24","chinese25");
      this.addLine(400,68,5,locale,"chinese26","chinese27");
    }

    private function addPartners(locale:Locale) : void {
      var type:String = null;
      var link:String = null;
      var partner:PartnerLogo = null;
      var offsetX:Number = 40;
      var offsetY:Number = 30;
      var gap:Number = 10;
      for(var i:int = locale.partners.length / 2; i >= 0; i--) {
        type = locale.partners[i * 2];
        link = locale.partners[i * 2 + 1];
        partner = new PartnerLogo(type,link);
        partner.x = stage.stageWidth - offsetX;
        partner.y = offsetY;
        addChild(partner);
        offsetX += gap + partner.actualWidth;
      }
    }

    override protected function onResize(e:Event) : void {
      this.x = 5;
      this.y = stage.stageHeight - bottomPanelHeight;
      this.redrawPanel();
      panel.scaleX = (stage.stageWidth - 10) / panel.width;
      panel.scaleY = bottomPanelHeight / panel.height + 2;
      if(panel.parent == null) {
        addChild(panel);
      }
    }

    private function redrawPanel() : void {
      var top:Number = NaN;
      var j:int = 0;
      var gridX:Array = [this.rectangle.left,this.rectangle.right,bottomLineData.width];
      var gridY:Array = [this.rectangle.top,this.rectangle.bottom,bottomLineData.height];
      panel.graphics.clear();
      var left:Number = 0;
      for(var i:int = 0; i < 3; i++) {
        top = 0;
        for(j = 0; j < 3; j++) {
          panel.graphics.beginBitmapFill(bottomLineData);
          panel.graphics.drawRect(left,top,gridX[i] - left,gridY[j] - top);
          panel.graphics.endFill();
          top = Number(gridY[j]);
        }
        left = Number(gridX[i]);
      }
      panel.scale9Grid = this.rectangle;
    }

    override public function switchLocale(locale:Locale) : void {
      removeChildren();
      addChild(panel);
      this.createLines(locale);
    }

    private function addText(type:String, locale:Locale, x:int, y:int) : LinkField {
      var linkField:LinkField = new LinkField(type,locale);
      linkField.x = x;
      linkField.y = y;
      addChild(linkField);
      return linkField;
    }

    private function addLine(x:int, y:int, gap:int, locale:Locale, ... args) : void {
      var type:String = null;
      var lf:LinkField = null;
      var offsetX:int = x;
      for each(type in args) {
        lf = this.addText(type,locale,offsetX,y);
        offsetX += lf.getLineMetrics(0).width + gap;
      }
    }
  }
}
