package forms {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.locale.ILocaleService;
  import base.DiscreteSprite;
  import controls.TankWindow;
  import controls.base.LabelBase;
  import filters.Filters;
  import flash.display.Bitmap;
  import flash.text.TextFormat;
  import resources.windowheaders.background.BackgroundHeader;

  public class TankWindowWithHeader extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private static const HEADER_BACKGROUND_HEIGHT:int = 25;
    private static const HEADER_BACKGROUND_INNER_HEIGHT:int = 22;

    private const GAP_11:int = 11;

    private var label:* = new LabelBase();
    private var window:TankWindow;
    private var headerBackground:Bitmap;

    public function TankWindowWithHeader(param1:String = null) {
      super();
      this.window = new TankWindow();
      addChild(this.window);
      this.initHeaderStyle();
      if(param1 != null) {
        this.setHeader(param1);
      }
    }

    public static function createWindow(param1:String, param2:int = -1, param3:int = -1) : TankWindowWithHeader {
      var local4:TankWindowWithHeader = new TankWindowWithHeader(localeService.getText(param1));
      local4.width = param2;
      local4.height = param3;
      return local4;
    }

    private function initHeaderStyle() : void {
      var local1:String = ILocaleService(OSGi.getInstance().getService(ILocaleService)).language;
      if(local1 == "fa") {
        this.label.setTextFormat(new TextFormat("IRANYekan"));
      } else if(local1 == "cn") {
        this.label.setTextFormat(new TextFormat("simsun"));
      }
      this.label.filters = Filters.SHADOW_FILTERS;
      this.label.size = 16;
      this.label.color = 12632256;
      this.label.bold = true;
    }

    private function setHeader(param1:String) : void {
      this.label.htmlText = param1;
      if(this.label.width > this.label.height) {
        if(this.label.width + 2 * this.GAP_11 < BackgroundHeader.shortBackgroundHeader.width) {
          this.headerBackground = new Bitmap(BackgroundHeader.shortBackgroundHeader);
        } else {
          this.headerBackground = new Bitmap(BackgroundHeader.longBackgroundHeader);
        }
      } else {
        this.headerBackground = new Bitmap(BackgroundHeader.verticalBackgroundHeader);
      }
      addChild(this.headerBackground);
      addChild(this.label);
      this.resize();
    }

    public function setHeaderId(param1:String) : void {
      this.setHeader(localeService.getText(param1));
    }

    override public function set width(param1:Number) : void {
      this.window.width = param1;
      this.resize();
    }

    override public function get width() : Number {
      return this.window.width;
    }

    override public function set height(param1:Number) : void {
      this.window.height = param1;
      this.resize();
    }

    override public function get height() : Number {
      return this.window.height;
    }

    private function resize() : void {
      if(this.headerBackground != null) {
        if(this.label.width > this.label.height) {
          this.headerBackground.x = this.window.width - this.headerBackground.width >> 1;
          this.headerBackground.y = -HEADER_BACKGROUND_HEIGHT;
          this.label.x = this.window.width - this.label.width >> 1;
          this.label.y = 5 - (HEADER_BACKGROUND_INNER_HEIGHT + this.label.height >> 1);
        } else {
          this.headerBackground.x = -HEADER_BACKGROUND_HEIGHT;
          this.headerBackground.y = this.window.height - this.headerBackground.height >> 1;
          this.label.x = 5 - (HEADER_BACKGROUND_INNER_HEIGHT + this.label.width >> 1);
          this.label.y = this.window.height - this.label.height >> 1;
        }
      }
    }
  }
}
