package alternativa.tanks.gui.alerts {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.startup.CacheLoader;
  import alternativa.tanks.gui.labels.TextWithCrystalsSmall;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.userproperties.IUserPropertiesService;
  import services.alertservice.AlertAnswer;

  public class RankUpBonusAlert extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var userPropertiesService:IUserPropertiesService;

    private const PIC_WIDTH:int = 400;
    private const PIC_HEIGHT:int = 234;
    private const windowWidth:int = 460;
    private const margin:int = 20;
    private const windowMargin:int = 12;
    private const picMarginTop:int = 5;
    private const picMarginBottom:int = -21;
    private const buttonMargin:int = 22;

    private var windowHeight:int;
    private var window:TankWindowWithHeader;

    public var button:DefaultButtonBase;

    public function RankUpBonusAlert(param1:int, param2:String) {
      var local6:LabelBase = null;
      var local7:TankWindowInner = null;
      this.button = new DefaultButtonBase();
      super();
      var local3:LabelBase = new LabelBase();
      local3.color = 4772391;
      local3.align = TextFormatAlign.CENTER;
      local3.size = 16;
      local3.bold = true;
      local3.text = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_RANK_UP_ACCRUED_CRYSTALS_CONGRATULATIONS,userPropertiesService.userName);
      local3.x = this.windowWidth - local3.width >> 1;
      local3.y = this.margin;
      addChild(local3);
      var local4:TextWithCrystalsSmall = new TextWithCrystalsSmall(localeService.getText(TanksLocale.TEXT_MAIN_PANEL_RANK_UP_ACCRUED_CRYSTALS_SUM,param1.toString()));
      local4.x = this.windowWidth - local4.width >> 1;
      local4.y = local3.y + local3.height - 3;
      addChild(local4);
      this.windowHeight = local4.y + local4.height;
      var local5:CacheLoader = new CacheLoader();
      local5.load(new URLRequest(param2));
      local5.x = this.windowWidth - this.PIC_WIDTH >> 1;
      local5.y = local4.y + local4.height + this.picMarginTop;
      addChild(local5);
      this.windowHeight += this.PIC_HEIGHT + this.picMarginTop;
      local6 = new LabelBase();
      local6.color = 4576301;
      local6.align = TextFormatAlign.LEFT;
      local6.multiline = true;
      local6.autoSize = TextFieldAutoSize.LEFT;
      local6.wordWrap = true;
      local6.size = 13;
      local6.text = localeService.getText(TanksLocale.TEXT_MAIN_PANEL_RANK_UP_ACCRUED_CRYSTALS_TEXT_MIDDLE_RANK);
      local6.x = 31;
      local6.y = local5.y + this.PIC_HEIGHT + this.picMarginBottom;
      local6.width = this.windowWidth - 27 - 31;
      addChild(local6);
      this.windowHeight += local6.height + this.picMarginBottom;
      this.button.label = AlertAnswer.OK;
      this.button.x = this.windowWidth - this.button.width >> 1;
      this.button.y = local6.y + local6.height + this.buttonMargin;
      addChild(this.button);
      this.windowHeight += this.button.height + this.buttonMargin + this.windowMargin + 1;
      local7 = new TankWindowInner(0,0,TankWindowInner.GREEN);
      local7.width = this.windowWidth - this.windowMargin * 2;
      local7.height = this.windowHeight - this.windowMargin * 2 - this.button.height - this.margin + 15;
      local7.x = this.windowMargin;
      local7.y = this.windowMargin;
      addChildAt(local7,0);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_ATTENTION,this.windowWidth,this.windowHeight);
      addChildAt(this.window,0);
      this.button.addEventListener(MouseEvent.CLICK,this.onClickCloseButton);
      dialogService.enqueueDialog(this);
    }

    private function onClickCloseButton(param1:MouseEvent = null) : void {
      this.button.removeEventListener(MouseEvent.CLICK,this.onClickCloseButton);
      dialogService.removeDialog(this);
    }

    override protected function cancelKeyPressed() : void {
      this.onClickCloseButton();
    }

    override protected function confirmationKeyPressed() : void {
      this.onClickCloseButton();
    }
  }
}
