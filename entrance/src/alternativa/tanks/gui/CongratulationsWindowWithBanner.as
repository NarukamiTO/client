package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.model.bonus.showing.detach.BonusDetach;
  import assets.icons.GarageItemBackground;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import forms.TankWindowWithHeader;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.bonus.showing.items.BonusItemCC;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class CongratulationsWindowWithBanner extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const tileClass:Class = CongratulationsWindowWithBanner_tileClass;
    private static const tileBitmapData:BitmapData = new tileClass().bitmapData;

    private const WINDOW_MARGIN:int = 12;
    private const MARGIN:int = 9;
    private const BUTTON_SIZE:Point;
    private const SPACE:int = 8;

    private var window:TankWindowWithHeader;
    private var inner:TankWindowInner;
    private var closeButton:DefaultButtonBase;
    private var messageLabel:LabelBase;
    private var windowSize:Point;
    private var windowWidth:int = 450;
    private var bannerBmp:Bitmap;
    private var itemsContainer:Sprite;
    private var _gameObject:IGameObject;

    public function CongratulationsWindowWithBanner(param1:IGameObject, param2:String, param3:Vector.<BonusItemCC>) {
      var local5:int = 0;
      var local10:PreviewBonusItem = null;
      var local11:LabelBase = null;
      this.BUTTON_SIZE = new Point(104,33);
      super();
      this._gameObject = param1;
      var local4:GarageItemBackground = new GarageItemBackground(GarageItemBackground.ENGINE_NORMAL);
      if(param3.length == 1) {
        local5 = 1;
      } else if(param3.length < 5) {
        local5 = 2;
      } else {
        local5 = 3;
      }
      this.windowWidth = local4.width + this.WINDOW_MARGIN * 2 + this.MARGIN * 2 + (local4.width + this.SPACE) * (local5 - 1);
      var local6:Sprite = new Sprite();
      this.itemsContainer = new Sprite();
      this.bannerBmp = new Bitmap(tileBitmapData);
      local6.addChild(this.bannerBmp);
      local6.y = this.WINDOW_MARGIN + this.MARGIN;
      local6.x = this.windowWidth - local6.width >> 1;
      this.messageLabel = new LabelBase();
      this.messageLabel.wordWrap = true;
      this.messageLabel.multiline = true;
      this.messageLabel.text = param2;
      this.messageLabel.size = 12;
      this.messageLabel.color = 5898034;
      this.messageLabel.x = this.WINDOW_MARGIN * 2;
      this.messageLabel.y = local6.y + local6.height + this.MARGIN;
      this.messageLabel.width = this.windowWidth - this.WINDOW_MARGIN * 4;
      this.windowSize = new Point(this.windowWidth,local6.height + this.messageLabel.height + this.BUTTON_SIZE.y + this.WINDOW_MARGIN * 3 + this.MARGIN * 4);
      this.window = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CONGRATULATION,this.windowSize.x,this.windowSize.y);
      addChild(this.window);
      this.inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.inner);
      this.inner.x = this.WINDOW_MARGIN;
      this.inner.y = this.WINDOW_MARGIN;
      this.inner.width = this.windowSize.x - this.WINDOW_MARGIN * 2;
      this.inner.height = this.windowSize.y - this.WINDOW_MARGIN - this.MARGIN * 2 - this.BUTTON_SIZE.y + 2;
      addChild(this.messageLabel);
      addChild(this.itemsContainer);
      var local7:int = param3.length % local5;
      var local8:int = (local5 - local7) * (local4.width + this.SPACE) >> 1;
      var local9:int = 0;
      while(local9 < param3.length) {
        local4 = new GarageItemBackground(GarageItemBackground.ENGINE_NORMAL);
        this.itemsContainer.addChild(local4);
        local10 = new PreviewBonusItem(param3[local9].resource,local4.width,local4.height);
        this.itemsContainer.addChild(local10);
        local4.x = (local9 >= param3.length - local7 ? local8 : 0) + int(local9 % local5) * (local4.width + this.SPACE);
        local4.y = (local4.height + this.SPACE) * int(local9 / local5);
        local10.x = local4.x;
        local10.y = local4.y;
        local11 = new LabelBase();
        this.itemsContainer.addChild(local11);
        local11.size = 16;
        local11.color = 5898034;
        local11.text = "×" + param3[local9].count.toString();
        local11.x = local4.x + local4.width - local11.width - 15;
        local11.y = local4.y + local4.height - local11.height - 10;
        local9++;
      }
      this.windowSize.y += this.itemsContainer.height;
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FREE_BONUSES_WINDOW_BUTTON_CLOSE_TEXT);
      this.closeButton.y = this.windowSize.y - this.MARGIN - this.BUTTON_SIZE.y - 2;
      this.placeItems();
      addChild(local6);
      this.window.height = this.windowSize.y;
      this.window.width = this.windowSize.x;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.closeBonusWindow);
      dialogService.enqueueDialog(this);
    }

    private function placeItems() : void {
      this.messageLabel.width = this.windowWidth - this.WINDOW_MARGIN * 4;
      this.itemsContainer.y = this.messageLabel.y + this.messageLabel.height + this.WINDOW_MARGIN;
      this.itemsContainer.x = this.windowSize.x - this.itemsContainer.width >> 1;
      this.inner.width = this.windowSize.x - this.WINDOW_MARGIN * 2;
      this.inner.height = this.windowSize.y - this.WINDOW_MARGIN - this.MARGIN * 2 - this.BUTTON_SIZE.y + 2;
      this.closeButton.x = this.windowSize.x - this.BUTTON_SIZE.x >> 1;
    }

    private function closeBonusWindow(param1:MouseEvent = null) : void {
      this.destroy();
    }

    public function destroy() : void {
      var local1:BonusDetach = null;
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.closeBonusWindow);
      dialogService.removeDialog(this);
      if(this._gameObject != null) {
        local1 = new BonusDetach(this._gameObject);
        local1.detach();
        this._gameObject = null;
      }
    }

    override protected function cancelKeyPressed() : void {
      this.closeBonusWindow();
    }

    override protected function confirmationKeyPressed() : void {
      this.closeBonusWindow();
    }
  }
}
