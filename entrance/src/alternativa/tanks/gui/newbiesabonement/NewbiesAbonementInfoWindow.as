package alternativa.tanks.gui.newbiesabonement {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.*;
  import alternativa.tanks.help.DateTimeHelper;
  import alternativa.tanks.newbieservice.NewbieUserService;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.text.TextFormatAlign;
  import forms.TankWindowWithHeader;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class NewbiesAbonementInfoWindow extends DialogWindow implements IDestroyWindow {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var newbieUserService:NewbieUserService;

    private static const NEWBIES_ABONEMENT_INFO_IMG:Class = NewbiesAbonementInfoWindow_NEWBIES_ABONEMENT_INFO_IMG;
    private static const NEWBIES_ABONEMENT_INFO_IMG_DATA:BitmapData = new NEWBIES_ABONEMENT_INFO_IMG().bitmapData;

    private var _isInit:Boolean;
    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var messageBottomLabel:LabelBase;
    private var presentBitmap:Bitmap = new Bitmap(NEWBIES_ABONEMENT_INFO_IMG_DATA);
    private var closeButton:DefaultButtonBase;
    private var windowWidth:int = 450;

    private const WINDOW_MARGIN:int = 12;
    private const MARGIN:int = 9;
    private const BUTTON_SIZE:Point = new Point(104,33);
    private const MIN_WIDTH:int = 300;

    private var _messageBottom:String;
    private var crystalBonusPattern:RegExp = /CRYSTAL_BONUS/gi;
    private var scoreBonusPattern:RegExp = /EXPERIENCE_BONUS/gi;

    public function NewbiesAbonementInfoWindow(param1:Date, param2:int, param3:int) {
      super();
      var local4:String = DateTimeHelper.formatDateTimeWithExpiredLabel(param1);
      this._messageBottom = localeService.getText(TanksLocale.TEXT_NEWBIES_ABONEMENT_WINDOW_TEXT);
      this._messageBottom += "\r\n" + local4;
      this._messageBottom = this._messageBottom.replace(this.crystalBonusPattern,param2).replace(this.scoreBonusPattern,param3);
      this.init();
    }

    private function init() : void {
      this._isInit = true;
      this.windowWidth = Math.max(this.presentBitmap.width + this.WINDOW_MARGIN * 2 + this.MARGIN * 2,this.MIN_WIDTH);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CONGRATULATION,this.windowWidth,this.presentBitmap.height);
      addChild(this.window);
      this.inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.inner);
      this.inner.x = this.WINDOW_MARGIN;
      this.inner.y = this.WINDOW_MARGIN;
      this.presentBitmap.x = this.windowWidth - this.presentBitmap.width >> 1;
      this.presentBitmap.y = this.WINDOW_MARGIN * 2;
      addChild(this.presentBitmap);
      this.messageBottomLabel = new LabelBase();
      this.messageBottomLabel.align = TextFormatAlign.LEFT;
      this.messageBottomLabel.wordWrap = true;
      this.messageBottomLabel.multiline = true;
      this.messageBottomLabel.size = 12;
      this.messageBottomLabel.color = 5898034;
      this.messageBottomLabel.htmlText = this._messageBottom;
      this.messageBottomLabel.x = this.WINDOW_MARGIN * 2;
      this.messageBottomLabel.y = this.presentBitmap.y + this.presentBitmap.height + this.MARGIN;
      this.messageBottomLabel.width = this.windowWidth - this.WINDOW_MARGIN * 4;
      addChild(this.messageBottomLabel);
      if(this.messageBottomLabel.numLines > 2) {
        this.messageBottomLabel.htmlText = this._messageBottom;
        this.messageBottomLabel.width = this.windowWidth - this.WINDOW_MARGIN * 4;
      }
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FREE_BONUSES_WINDOW_BUTTON_CLOSE_TEXT);
      var local1:int = this.presentBitmap.height + this.closeButton.height + this.MARGIN * 2 + this.WINDOW_MARGIN * 3;
      if(this.messageBottomLabel != null) {
        local1 += this.messageBottomLabel.height + this.MARGIN;
      }
      this.window.height = local1;
      this.closeButton.y = this.window.height - this.MARGIN - 35;
      this.closeButton.x = this.window.width - this.closeButton.width >> 1;
      this.inner.width = this.window.width - this.WINDOW_MARGIN * 2;
      this.inner.height = this.window.height - this.WINDOW_MARGIN - this.MARGIN * 2 - this.BUTTON_SIZE.y + 2;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.closeWindow);
      dialogService.enqueueDialog(this);
    }

    private function closeWindow(param1:MouseEvent = null) : void {
      if(newbieUserService.isNewbieUser) {
        newbieUserService.isNewbieUser = false;
      }
      this.destroy();
    }

    public function destroy() : void {
      if(this._isInit) {
        this._isInit = false;
        this.closeButton.removeEventListener(MouseEvent.CLICK,this.closeWindow);
        dialogService.removeDialog(this);
      }
    }

    override protected function cancelKeyPressed() : void {
      this.closeWindow();
    }

    override protected function confirmationKeyPressed() : void {
      this.closeWindow();
    }
  }
}
