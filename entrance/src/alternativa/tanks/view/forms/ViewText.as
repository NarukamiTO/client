package alternativa.tanks.view.forms {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindow;
  import controls.base.DefaultButtonBase;
  import fl.controls.UIScrollBar;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.text.AntiAliasType;
  import flash.text.GridFitType;
  import flash.text.TextField;
  import flash.text.TextFormat;
  import fonts.TanksFontService;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import utils.FontParamsUtil;

  public class ViewText extends Sprite {
    [Inject]
    public var localeService:ILocaleService;

    private var output:TextField;
    private var format:TextFormat;
    private var scrollBar:UIScrollBar = new UIScrollBar();

    public var closeButton:DefaultButtonBase = new DefaultButtonBase();

    public function ViewText() {
      super();
    }

    [PostConstruct]
    public function postConstruct() : void {
      var local1:TankWindow = new TankWindow(400,500);
      addChild(local1);
      this.format = TanksFontService.getTextFormat(13);
      this.output = new TextField();
      addChild(this.output);
      this.output.background = false;
      this.output.multiline = true;
      this.output.wordWrap = true;
      this.output.x = 35;
      this.output.y = 35;
      this.output.width = 315;
      this.output.height = 375;
      this.output.embedFonts = TanksFontService.isEmbedFonts();
      this.output.antiAliasType = AntiAliasType.ADVANCED;
      this.output.gridFitType = GridFitType.SUBPIXEL;
      this.output.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      this.output.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
      this.output.defaultTextFormat = this.format;
      addChild(this.scrollBar);
      this.scrollBar.move(this.output.x + this.output.width,this.output.y);
      this.scrollBar.setSize(this.scrollBar.width,this.output.height);
      this.scrollBar.scrollTarget = this.output;
      addChild(this.closeButton);
      this.closeButton.x = 148;
      this.closeButton.y = 435;
      this.closeButton.label = "123123Close";
      this.closeButton.label = this.localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      this.closeButton.addEventListener(MouseEvent.CLICK,this.hide);
      stage.addEventListener(Event.RESIZE,this.onResize);
      this.onResize(null);
    }

    private function onResize(param1:Event) : void {
      this.x = int((stage.stageWidth - this.width) / 2);
      this.y = int((stage.stageHeight - this.height) / 2);
    }

    private function hide(param1:MouseEvent) : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.hide);
      stage.removeEventListener(Event.RESIZE,this.onResize);
      this.visible = false;
      parent.removeChild(this);
    }

    public function set text(param1:String) : void {
      this.output.htmlText = param1;
      this.scrollBar.update();
      if(this.scrollBar.maxScrollPosition == 0) {
        this.scrollBar.visible = false;
      }
    }

    override public function get width() : Number {
      return 400;
    }

    override public function get height() : Number {
      return 500;
    }
  }
}
