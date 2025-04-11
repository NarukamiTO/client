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

  public class RepatriateBonusWindow extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private static const WINDOW_MARGIN:int = 12;
    private static const MARGIN:int = 9;
    private static const BUTTON_SIZE:Point = new Point(104,33);
    private static const SPACE:int = 8;

    private var inner:TankWindowInner;
    private var closeButton:DefaultButtonBase;
    private var messageLabel:LabelBase;
    private var windowSize:Point;
    private var windowWidth:int = 450;
    private var itemsContainer:Sprite;
    private var _gameObject:IGameObject;

    public function RepatriateBonusWindow(param1:IGameObject, param2:BitmapData, param3:String, param4:Vector.<BonusItemCC>) {
      var local6:int = 0;
      var local7:TankWindowWithHeader = null;
      var local11:PreviewBonusItem = null;
      var local12:int = 0;
      var local13:int = 0;
      super();
      this._gameObject = param1;
      var local5:GarageItemBackground = new GarageItemBackground(GarageItemBackground.ENGINE_NORMAL);
      if(param4.length == 1) {
        local6 = 1;
      } else if(param4.length <= 4) {
        local6 = 2;
      } else if(param4.length <= 6) {
        local6 = 3;
      } else {
        local6 = 4;
      }
      this.itemsContainer = new Sprite();
      this.windowWidth = local5.width + WINDOW_MARGIN * 2 + MARGIN * 2 + (local5.width + SPACE) * (local6 - 1);
      this.messageLabel = new LabelBase();
      this.messageLabel.wordWrap = true;
      this.messageLabel.multiline = true;
      this.messageLabel.text = param3;
      this.messageLabel.size = 12;
      this.messageLabel.color = 5898034;
      this.messageLabel.x = WINDOW_MARGIN * 2;
      this.messageLabel.y = 110 + WINDOW_MARGIN * 2;
      this.messageLabel.width = this.windowWidth - WINDOW_MARGIN * 4;
      this.windowSize = new Point(this.windowWidth,110 + this.messageLabel.height + BUTTON_SIZE.y + WINDOW_MARGIN * 3 + MARGIN * 3);
      local7 = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_WELCOME_BACK,this.windowSize.x,this.windowSize.y);
      addChild(local7);
      this.inner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      addChild(this.inner);
      this.inner.x = WINDOW_MARGIN;
      this.inner.y = WINDOW_MARGIN;
      this.inner.width = this.windowSize.x - WINDOW_MARGIN * 2;
      this.inner.height = this.windowSize.y - WINDOW_MARGIN - MARGIN * 2 - BUTTON_SIZE.y + 2;
      var local8:Bitmap = new Bitmap(param2);
      local8.y = WINDOW_MARGIN * 2;
      local8.x = this.inner.width - local8.width >> 1;
      this.inner.addChild(local8);
      addChild(this.messageLabel);
      addChild(this.itemsContainer);
      var local9:int = int(param4.length / local6) + 1;
      var local10:int = 0;
      while(local10 < param4.length) {
        local5 = new GarageItemBackground(GarageItemBackground.ENGINE_NORMAL);
        this.itemsContainer.addChild(local5);
        local11 = new PreviewBonusItem(param4[local10].resource,local5.width,local5.height);
        this.itemsContainer.addChild(local11);
        if(int(local10 / local6) + 1 == local9) {
          local12 = param4.length - (local9 - 1) * local6;
          local13 = (local6 - local12) * (local5.width + SPACE >> 1);
          local5.x = int(local10 % local6) * (local5.width + SPACE) + local13;
        } else {
          local5.x = int(local10 % local6) * (local5.width + SPACE);
        }
        local5.y = (local5.height + SPACE) * int(local10 / local6);
        local11.x = local5.x;
        local11.y = local5.y;
        local10++;
      }
      this.windowSize.y += this.itemsContainer.height;
      this.closeButton = new DefaultButtonBase();
      addChild(this.closeButton);
      this.closeButton.label = localeService.getText(TanksLocale.TEXT_FREE_BONUSES_WINDOW_BUTTON_CLOSE_TEXT);
      this.closeButton.y = this.windowSize.y - MARGIN - BUTTON_SIZE.y - 2;
      this.placeItems();
      local7.height = this.windowSize.y;
      local7.width = this.windowSize.x;
      this.closeButton.addEventListener(MouseEvent.CLICK,this.onCloseBonusClick);
      dialogService.enqueueDialog(this);
    }

    private function placeItems() : void {
      this.messageLabel.width = this.windowWidth - WINDOW_MARGIN * 4;
      this.itemsContainer.y = this.messageLabel.y + this.messageLabel.height + WINDOW_MARGIN;
      this.itemsContainer.x = this.windowSize.x - this.itemsContainer.width >> 1;
      this.inner.width = this.windowSize.x - WINDOW_MARGIN * 2;
      this.inner.height = this.windowSize.y - WINDOW_MARGIN - MARGIN * 2 - BUTTON_SIZE.y + 2;
      this.closeButton.x = this.windowSize.x - BUTTON_SIZE.x >> 1;
    }

    private function onCloseBonusClick(param1:MouseEvent = null) : void {
      this.destroy();
    }

    public function destroy() : void {
      var local1:BonusDetach = null;
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.onCloseBonusClick);
      dialogService.removeDialog(this);
      if(this._gameObject != null) {
        local1 = new BonusDetach(this._gameObject);
        local1.detach();
        this._gameObject = null;
      }
    }

    override protected function cancelKeyPressed() : void {
      this.onCloseBonusClick();
    }

    override protected function confirmationKeyPressed() : void {
      this.onCloseBonusClick();
    }
  }
}
