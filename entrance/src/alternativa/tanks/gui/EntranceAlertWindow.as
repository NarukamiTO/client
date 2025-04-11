package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.text.TextFormatAlign;
  import forms.TankWindowWithHeader;
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class EntranceAlertWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var messageTopLabel:LabelBase;
    private var messageBottomLabel:LabelBase;
    private var closeButton:DefaultButtonBase;

    private const windowMargin:int = 12;
    private const margin:int = 9;
    private const buttonSize:Point = new Point(104,33);

    private var windowSize:Point;

    public function EntranceAlertWindow(param1:LocalizedImageResource, param2:String, param3:String) {
      super();
      this.windowSize = new Point(430,300);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_ATTENTION,this.windowSize.x,this.windowSize.y);
      addChild(this.window);
      this.inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.inner);
      this.inner.x = this.windowMargin;
      this.inner.y = this.windowMargin;
      this.messageTopLabel = new LabelBase();
      this.messageTopLabel.align = TextFormatAlign.CENTER;
      this.messageTopLabel.wordWrap = true;
      this.messageTopLabel.multiline = true;
      this.messageTopLabel.size = 18;
      this.messageTopLabel.bold = true;
      this.messageTopLabel.text = param2;
      this.messageTopLabel.color = 5898034;
      this.messageTopLabel.x = this.windowMargin * 2;
      this.messageTopLabel.width = this.windowSize.x - this.windowMargin * 4;
      addChild(this.messageTopLabel);
      this.messageBottomLabel = new LabelBase();
      this.messageBottomLabel.align = TextFormatAlign.LEFT;
      this.messageBottomLabel.wordWrap = true;
      this.messageBottomLabel.multiline = true;
      this.messageBottomLabel.size = 12;
      this.messageBottomLabel.color = 5898034;
      this.messageBottomLabel.htmlText = param3;
      this.messageBottomLabel.x = this.windowMargin * 2;
      this.messageBottomLabel.y = this.messageTopLabel.y + this.messageTopLabel.height;
      this.messageBottomLabel.width = this.windowSize.x - this.windowMargin * 4;
      addChild(this.messageBottomLabel);
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FREE_BONUSES_WINDOW_BUTTON_CLOSE_TEXT);
      this.closeButton.y = this.window.height - this.margin - 35;
      this.closeButton.x = this.window.width - this.closeButton.width >> 1;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.inner.width = this.window.width - this.windowMargin * 2;
      this.addImage(param1);
      dialogService.enqueueDialog(this);
    }

    private function addImage(param1:LocalizedImageResource) : void {
      var local2:Bitmap = new Bitmap(param1.data);
      this.windowSize.x = Math.max(this.messageBottomLabel.width,Math.max(local2.width,this.messageTopLabel.width)) + this.windowMargin * 2 + this.margin * 2;
      local2.x = (this.windowSize.x - local2.width) / 2;
      local2.y = this.inner.y + this.windowMargin;
      addChild(local2);
      this.messageTopLabel.y = local2.y + local2.height + 10;
      this.messageBottomLabel.y = this.messageTopLabel.y + this.messageTopLabel.height;
      this.messageTopLabel.x = (this.windowSize.x - this.messageTopLabel.width) / 2;
      this.messageBottomLabel.x = (this.windowSize.x - this.messageBottomLabel.width) / 2;
      this.messageTopLabel.width = this.windowSize.x - this.windowMargin * 4;
      this.inner.width = this.windowSize.x - this.windowMargin * 2;
      this.inner.height = local2.height + this.messageTopLabel.height + this.messageBottomLabel.height + this.closeButton.height + this.margin - 1;
      this.closeButton.x = this.windowSize.x - this.buttonSize.x >> 1;
      this.closeButton.y = this.inner.y + this.inner.height + this.margin - 2;
      this.windowSize.y = this.closeButton.y + this.closeButton.height + 2 * this.margin;
      this.window.height = this.windowSize.y;
      this.window.width = this.windowSize.x;
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      dialogService.removeDialog(this);
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseButtonClick();
    }

    override protected function confirmationKeyPressed() : void {
      this.onCloseButtonClick();
    }
  }
}
