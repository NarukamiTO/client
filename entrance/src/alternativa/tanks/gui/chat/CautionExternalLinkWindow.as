package alternativa.tanks.gui.chat {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class CautionExternalLinkWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static var bitmapDataClass:Class = CautionExternalLinkWindow_bitmapDataClass;
    private static var bitmapData:BitmapData = Bitmap(new bitmapDataClass()).bitmapData;

    private static const WINDOW_WIDTH:int = 608;
    private static const WINDOW_MARGIN:int = 11;

    private var closeButton:DefaultButtonBase;
    private var window:TankWindowWithHeader;
    private var cautionImage:Bitmap;
    private var linkLabel:LabelBase;
    private var innerWindow:TankWindowInner;

    public function CautionExternalLinkWindow(param1:String) {
      super();
      this.addWindow();
      this.addCautionImage();
      this.addLinkBlock(param1);
      this.addCautionLabel();
      this.addCloseButton();
      this.setWindowSize();
    }

    private function addWindow() : void {
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CAUTION_EXTERNAL_LINK);
      addChild(this.window);
      this.window.width = WINDOW_WIDTH;
    }

    private function addCautionImage() : void {
      this.cautionImage = new Bitmap(bitmapData);
      this.cautionImage.x = WINDOW_MARGIN - 2;
      this.cautionImage.y = WINDOW_MARGIN;
      this.window.addChild(this.cautionImage);
    }

    private function addLinkBlock(param1:String) : void {
      this.innerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.innerWindow.x = WINDOW_MARGIN;
      this.innerWindow.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this.window.addChild(this.innerWindow);
      this.linkLabel = new LabelBase();
      this.linkLabel.wordWrap = true;
      this.linkLabel.multiline = true;
      this.linkLabel.text = localeService.getText(TanksLocale.TEXT_FOLLOW_EXTERNAL_LINK).replace("%link%",param1);
      this.linkLabel.size = 12;
      this.linkLabel.x = WINDOW_MARGIN * 2;
      this.linkLabel.y = this.cautionImage.y + this.cautionImage.height + WINDOW_MARGIN * 2;
      this.linkLabel.width = WINDOW_WIDTH - WINDOW_MARGIN * 4;
      this.window.addChild(this.linkLabel);
    }

    private function addCautionLabel() : void {
      var local1:LabelBase = new LabelBase();
      local1.wordWrap = true;
      local1.multiline = true;
      local1.text = localeService.getText(TanksLocale.TEXT_CONSEQUENCES_EXTERNAL_LINK_FOLLOWING);
      local1.size = 12;
      local1.x = this.linkLabel.x;
      local1.y = this.linkLabel.y + this.linkLabel.height + WINDOW_MARGIN;
      local1.width = this.linkLabel.width;
      this.window.addChild(local1);
      this.innerWindow.y = this.linkLabel.y - WINDOW_MARGIN;
      this.innerWindow.height = local1.height + this.linkLabel.height + WINDOW_MARGIN * 3;
    }

    private function addCloseButton() : void {
      this.closeButton = new DefaultButtonBase();
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = WINDOW_WIDTH - WINDOW_MARGIN - this.closeButton.width;
      this.closeButton.y = this.innerWindow.y + this.innerWindow.height + WINDOW_MARGIN;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.window.addChild(this.closeButton);
    }

    public function show() : void {
      dialogService.enqueueDialog(this);
    }

    private function setWindowSize() : void {
      this.window.height = this.closeButton.y + this.closeButton.height + WINDOW_MARGIN;
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseButtonClick();
    }

    override protected function confirmationKeyPressed() : void {
      this.onCloseButtonClick();
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      dialogService.removeDialog(this);
      dispatchEvent(new CautionExternalLinkWindowEvent(CautionExternalLinkWindowEvent.CLOSING));
    }
  }
}
