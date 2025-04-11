package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.events.MouseEvent;
  import flash.text.TextFieldAutoSize;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class RulesUpdateAlert extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private const INNER_MARGIN:int = 12;
    private const TEXT_X:int = 20;
    private const TEXT_Y:int = 15;
    private const WINDOW_WIDTH:int = 495;

    private var okButton:DefaultButtonBase;
    private var onAcceptFunction:Function;

    public function RulesUpdateAlert(param1:String, param2:String, param3:Function) {
      var local4:LabelBase = null;
      this.okButton = new DefaultButtonBase();
      super();
      this.onAcceptFunction = param3;
      local4 = new LabelBase();
      local4.multiline = true;
      local4.wordWrap = true;
      local4.width = this.WINDOW_WIDTH - 2 * (this.INNER_MARGIN + this.TEXT_X);
      local4.autoSize = TextFieldAutoSize.LEFT;
      local4.x = this.INNER_MARGIN + this.TEXT_X;
      local4.y = this.INNER_MARGIN + this.TEXT_Y;
      local4.text = param1;
      var local5:LabelBase = new LabelBase();
      local5.multiline = true;
      local5.autoSize = TextFieldAutoSize.LEFT;
      local5.x = local4.x;
      local5.y = local4.y + local4.height + 20;
      local5.htmlText = param2;
      var local6:int = local5.y + local5.height + this.TEXT_Y;
      var local7:TankWindowInner = new TankWindowInner(this.WINDOW_WIDTH - this.INNER_MARGIN * 2,local6,TankWindowInner.GREEN);
      local7.x = this.INNER_MARGIN;
      local7.y = this.INNER_MARGIN;
      this.okButton.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      this.okButton.x = (this.WINDOW_WIDTH - this.okButton.width) / 2;
      this.okButton.y = local7.y + local6 + 5;
      this.okButton.addEventListener(MouseEvent.CLICK,this.onOkButtonClick);
      var local8:TankWindowWithHeader = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_NEWS,this.WINDOW_WIDTH,this.INNER_MARGIN + local6 + 5 + this.okButton.height + 15);
      addChild(local8);
      local8.addChild(local7);
      local8.addChild(local4);
      local8.addChild(local5);
      local8.addChild(this.okButton);
    }

    private function onOkButtonClick(param1:MouseEvent) : void {
      this.okButton.removeEventListener(MouseEvent.CLICK,this.onOkButtonClick);
      this.onAcceptFunction();
    }

    override protected function confirmationKeyPressed() : void {
      this.okButton.removeEventListener(MouseEvent.CLICK,this.onOkButtonClick);
      this.onAcceptFunction();
    }
  }
}
