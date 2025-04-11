package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.bonus.showing.detach.BonusDetach;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.text.TextFormatAlign;
  import forms.TankWindowWithHeader;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class CongratulationsWindowConfiscate extends DialogWindow implements IDestroyWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private var _gameObject:IGameObject;
    private var closeButton:DefaultButtonBase;

    private const windowMargin:int = 12;
    private const margin:int = 9;
    private const buttonSize:Point;
    private const minWidth:int = 300;

    public function CongratulationsWindowConfiscate(param1:IGameObject, param2:BitmapData, param3:BitmapData, param4:String = "", param5:String = "", param6:int = 0) {
      var local12:LabelBase = null;
      var local13:LabelBase = null;
      this.buttonSize = new Point(104,33);
      super();
      this._gameObject = param1;
      var local7:Bitmap = new Bitmap(param2);
      var local8:Bitmap = new Bitmap(param3);
      var local9:int = Math.max(local8.width + this.windowMargin * 2 + this.margin * 2,local7.width + this.windowMargin * 2 + this.margin * 2,this.minWidth);
      var local10:TankWindowWithHeader = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_ATTENTION,local9,local7.height);
      addChild(local10);
      var local11:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(local11);
      local11.x = this.windowMargin;
      local11.y = this.windowMargin;
      local8.x = local9 - local8.width >> 1;
      local8.y = this.windowMargin * 2 - 7;
      addChild(local8);
      if(param4 != null && param4 != "") {
        local12 = new LabelBase();
        local12.align = TextFormatAlign.CENTER;
        local12.wordWrap = true;
        local12.multiline = true;
        local12.size = 13;
        local12.htmlText = param4;
        local12.color = 5898034;
        local12.x = this.windowMargin * 2;
        local12.y = local8.y + local8.height + this.margin - 28;
        local12.width = local9 - this.windowMargin * 4;
        addChild(local12);
      }
      local7.x = local9 - local7.width >> 1;
      local7.y = local12.y + local12.height + this.margin - 5;
      addChild(local7);
      if(param5 != null && param5 != "") {
        local13 = new LabelBase();
        local13.align = TextFormatAlign.CENTER;
        local13.wordWrap = true;
        local13.multiline = true;
        local13.size = 12;
        local13.color = 5898034;
        local13.htmlText = String(param5.split("\n")[0]);
        local13.x = this.windowMargin * 2;
        local13.y = local7.y + local7.height + this.margin - 17;
        local13.width = local9 - this.windowMargin * 4;
        addChild(local13);
      }
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FREE_BONUSES_WINDOW_BUTTON_CLOSE_TEXT);
      var local14:int = local8.height + local7.height + this.closeButton.height + this.margin * 3 + this.windowMargin * 3;
      if(local12 != null) {
        local14 += local12.height + this.margin;
      }
      if(local13 != null) {
        local14 += local13.height + this.margin;
      }
      local10.height = local14 - 5 - 28 - 7 - 17;
      this.closeButton.y = local10.height - this.margin - 35;
      this.closeButton.x = local10.width - this.closeButton.width >> 1;
      local11.width = local10.width - this.windowMargin * 2;
      local11.height = local10.height - this.windowMargin - this.margin * 2 - this.buttonSize.y + 2;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onClickCloseButton);
      dialogService.enqueueDialog(this);
    }

    private function onClickCloseButton(param1:MouseEvent = null) : void {
      this.destroy();
    }

    public function destroy() : void {
      var local1:BonusDetach = null;
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onClickCloseButton);
      dialogService.removeDialog(this);
      if(this._gameObject != null) {
        local1 = new BonusDetach(this._gameObject);
        local1.detach();
        this._gameObject = null;
      }
    }

    override protected function cancelKeyPressed() : void {
      this.onClickCloseButton();
    }

    override protected function confirmationKeyPressed() : void {
      this.onClickCloseButton();
    }
  }
}
