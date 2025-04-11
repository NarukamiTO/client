package alternativa.tanks.gui.socialnetwork {
  import alternativa.osgi.service.locale.ILocaleService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;
  import flash.ui.Mouse;
  import flash.ui.MouseCursor;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class AbstractSNGroupEnteringWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const WINDOW_WIDTH:int = 350;
    private static const WINDOW_MARGIN:int = 11;
    private static const GAP:int = 5;

    private var image:Bitmap;
    private var window:TankWindowWithHeader;
    private var imageInnerWindow:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
    private var labelInnerWindow:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
    private var closeButton:DefaultButtonBase = new DefaultButtonBase();
    private var snGroupUrl:String;

    public function AbstractSNGroupEnteringWindow(param1:BitmapData, param2:String, param3:String) {
      super();
      this.snGroupUrl = param2;
      this.addWindow();
      this.addImage(param1);
      this.addLabel(param3);
      this.addCloseButton();
      this.setWindowSize();
    }

    private function addWindow() : void {
      this.window = new TankWindowWithHeader(localeService.getText(TanksLocale.TEXT_HEADER_VK_ENTERING_GROUP));
      this.window.width = WINDOW_WIDTH;
      addChild(this.window);
    }

    private function addImage(param1:BitmapData) : void {
      this.image = new Bitmap(param1);
      this.image.x = WINDOW_MARGIN;
      this.imageInnerWindow = new TankWindowInner(0,0,TankWindowInner.GREEN);
      this.imageInnerWindow.x = WINDOW_MARGIN;
      this.imageInnerWindow.y = WINDOW_MARGIN;
      this.imageInnerWindow.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this.imageInnerWindow.height = this.image.height;
      this.window.addChild(this.imageInnerWindow);
      this.imageInnerWindow.addEventListener(MouseEvent.CLICK,this.onImageClick);
      this.imageInnerWindow.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutOfImage);
      this.imageInnerWindow.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverImage);
      this.imageInnerWindow.addChild(this.image);
    }

    private function onMouseOutOfImage(param1:MouseEvent) : void {
      Mouse.cursor = MouseCursor.AUTO;
    }

    private function onMouseOverImage(param1:MouseEvent) : void {
      Mouse.cursor = MouseCursor.BUTTON;
    }

    private function onImageClick(param1:MouseEvent) : void {
      navigateToURL(new URLRequest(this.snGroupUrl),"_blank");
    }

    private function addLabel(param1:String) : void {
      this.labelInnerWindow.x = WINDOW_MARGIN;
      this.labelInnerWindow.width = WINDOW_WIDTH - WINDOW_MARGIN * 2;
      this.window.addChild(this.labelInnerWindow);
      var local2:LabelBase = new LabelBase();
      local2.wordWrap = true;
      local2.multiline = true;
      local2.htmlText = param1;
      local2.x = WINDOW_MARGIN;
      local2.y = WINDOW_MARGIN;
      local2.width = WINDOW_WIDTH - WINDOW_MARGIN * 4;
      this.labelInnerWindow.addChild(local2);
      this.labelInnerWindow.height = local2.height + WINDOW_MARGIN * 2;
      this.labelInnerWindow.y = this.imageInnerWindow.y + this.imageInnerWindow.height + GAP;
    }

    public function show() : void {
      dialogService.enqueueDialog(this);
    }

    private function addCloseButton() : void {
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_CLOSE_LABEL);
      this.closeButton.x = WINDOW_WIDTH - WINDOW_MARGIN - this.closeButton.width;
      this.closeButton.y = this.labelInnerWindow.y + this.labelInnerWindow.height + GAP;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.window.addChild(this.closeButton);
    }

    private function onCloseButtonClick(param1:MouseEvent = null) : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseButtonClick);
      this.imageInnerWindow.removeEventListener(MouseEvent.CLICK,this.onImageClick);
      this.imageInnerWindow.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverImage);
      this.imageInnerWindow.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutOfImage);
      dialogService.removeDialog(this);
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
  }
}
