package alternativa.tanks.gui {
  import alternativa.osgi.service.locale.ILocaleService;
  import assets.icons.GarageItemBackground;
  import controls.TankWindowInner;
  import controls.base.DefaultButtonBase;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import forms.TankWindowWithHeader;
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.panel.model.garage.rankupsupplybonus.RankUpSupplyBonusInfo;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.dialogs.gui.DialogWindow;

  public class RankUpSupplyBonusAlert extends DialogWindow {
    [Inject]
    public static var localeService:ILocaleService;

    private var closeButton:DefaultButtonBase;

    private const BORDER:int = 12;
    private const MARGIN:int = 12;

    public function RankUpSupplyBonusAlert(param1:RankUpSupplyBonusInfo) {
      super();
      this.createAlertWindow(this,param1);
      dialogService.enqueueDialog(this);
    }

    public function createAlertWindow(param1:Sprite, param2:RankUpSupplyBonusInfo) : void {
      var local3:TankWindowWithHeader = TankWindowWithHeader.createWindow(TanksLocale.TEXT_HEADER_CONGRATULATION);
      param1.addChild(local3);
      var local4:TankWindowInner = this.createInnerFrame(local3,param2);
      this.closeButton = this.createCloseButton(local3);
      local3.width = local4.width + this.BORDER * 2;
      local3.height = local4.height + this.closeButton.height + this.BORDER * 3 - 4;
      this.closeButton.x = (local3.width - this.closeButton.width) / 2;
      this.closeButton.y = local4.height + this.BORDER * 2 - 6;
    }

    private function createInnerFrame(param1:Sprite, param2:RankUpSupplyBonusInfo) : TankWindowInner {
      var local3:TankWindowInner = new TankWindowInner(0,0,TankWindowInner.GREEN);
      param1.addChild(local3);
      local3.x = this.BORDER;
      local3.y = this.BORDER;
      var local4:GarageItemBackground = this.createItemPlate(local3);
      var local5:LabelBase = this.createDescriptionLabel(local3,param2.text,local4.width);
      this.placeItemPlate(local4,param2,this.MARGIN - 3,local5.height + this.MARGIN * 2);
      local3.width = local4.width + this.MARGIN * 2 - 6;
      local3.height = local5.height + this.MARGIN * 3 + local4.height - 2;
      return local3;
    }

    private function createItemPlate(param1:Sprite) : GarageItemBackground {
      var local2:GarageItemBackground = new GarageItemBackground(GarageItemBackground.ENGINE_NORMAL);
      param1.addChild(local2);
      return local2;
    }

    private function createDescriptionLabel(param1:Sprite, param2:String, param3:int) : LabelBase {
      var local4:LabelBase = new LabelBase();
      param1.addChild(local4);
      local4.wordWrap = true;
      local4.multiline = true;
      local4.text = param2;
      local4.size = 12;
      local4.color = 5898034;
      local4.x = this.MARGIN - 2;
      local4.y = this.MARGIN;
      local4.width = param3;
      return local4;
    }

    private function placeItemPlate(param1:GarageItemBackground, param2:RankUpSupplyBonusInfo, param3:int, param4:int) : void {
      param1.x = param3;
      param1.y = param4;
      this.createPreview(param1,param2.preview);
      this.createCountLabel(param1,param2.count);
    }

    private function createPreview(param1:Sprite, param2:ImageResource) : void {
      var local3:PreviewBonusItem = new PreviewBonusItem(param2,param1.width,param1.height);
      param1.addChild(local3);
    }

    private function createCountLabel(param1:Sprite, param2:int) : void {
      var local3:LabelBase = new LabelBase();
      param1.addChild(local3);
      local3.size = 16;
      local3.color = 5898034;
      local3.text = "×" + param2;
      local3.x = param1.width - local3.width - 15;
      local3.y = param1.height - local3.height - 10;
    }

    private function createCloseButton(param1:Sprite) : DefaultButtonBase {
      var local2:DefaultButtonBase = new DefaultButtonBase();
      local2.label = localeService.getText(TanksLocale.TEXT_ALERT_ANSWER_OK);
      local2.addEventListener(MouseEvent.CLICK,this.closeBonusWindow);
      param1.addChild(local2);
      return local2;
    }

    private function closeBonusWindow(param1:MouseEvent = null) : void {
      this.destroy();
    }

    public function destroy() : void {
      this.closeButton.removeEventListener(MouseEvent.CLICK,this.closeBonusWindow);
      dialogService.removeDialog(this);
    }

    override protected function cancelKeyPressed() : void {
      this.closeBonusWindow();
    }

    override protected function confirmationKeyPressed() : void {
      this.closeBonusWindow();
    }
  }
}
