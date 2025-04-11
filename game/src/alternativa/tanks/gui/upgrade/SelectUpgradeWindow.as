package alternativa.tanks.gui.upgrade {
  import alternativa.tanks.gui.crystalbutton.CrystalButton;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import alternativa.tanks.service.itempropertyparams.ItemPropertyParamsService;
  import alternativa.tanks.service.money.IMoneyService;
  import controls.TankWindowInner;
  import controls.buttons.h50px.GreyBigButtonSkin;
  import controls.buttons.skins.GoldBigButtonSkin;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnTick;
  import flash.events.MouseEvent;
  import flash.utils.getTimer;
  import flash.utils.setTimeout;
  import projects.tanks.clients.flash.commons.services.layout.event.LobbyLayoutServiceEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.layout.ILobbyLayoutService;

  public class SelectUpgradeWindow extends UpgradeWindowBase implements CountDownTimerOnTick {
    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var propertyService:ItemPropertyParamsService;

    [Inject]
    public static var lobbyLayoutService:ILobbyLayoutService;

    private static const BUTTON_WIDTH:int = 136;
    private static const VERTICAL_MARGIN:int = 7;
    private static const UPGRADE_TIMEOUT_MS:int = 750;

    private var inner:TankWindowInner;
    private var properties:Vector.<UpgradableItemPropertyValue>;
    private var infos:Vector.<UpgradeInfoForm>;
    private var timer:CountDownTimer;
    private var upgradableItemParams:UpgradableItemParams;
    private var progress:UpgradeProgressForm;
    private var okButton:CrystalButton;

    public function SelectUpgradeWindow(param1:UpgradableItemParams) {
      var local5:UpgradeInfoForm = null;
      this.okButton = new CrystalButton();
      this.upgradableItemParams = param1;
      this.properties = this.getUpgradableProperties(param1.properties);
      super(465,39 * this.properties.length + 152);
      this.inner = new TankWindowInner(440,39 * this.properties.length + 12,TankWindowInner.GREEN);
      this.inner.x = 12;
      this.inner.y = 13;
      addChild(this.inner);
      this.infos = new Vector.<UpgradeInfoForm>(this.properties.length);
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = 0;
      while(local4 < this.properties.length) {
        local5 = new UpgradeInfoForm(param1,this.properties[local4]);
        local2 = Math.max(local2,local5.getValueMaxWidth());
        local3 = Math.max(local3,local5.getPropertyNameWidth());
        this.infos[local4] = local5;
        local5.y = 39 * local4 + 12;
        this.inner.addChild(local5);
        local4++;
      }
      this.infos[0].align(local3,local2);
      if(!param1.isFullUpgraded()) {
        local3 += Math.max(375 - this.infos[0].getWidth(),0);
      } else {
        local3 += Math.max(200 - this.infos[0].getWidth(),0);
      }
      for each(local5 in this.infos) {
        local5.align(local3,local2);
      }
      this.progress = new UpgradeProgressForm(param1);
      this.progress.x = 12;
      this.progress.y = this.inner.y + this.inner.height + VERTICAL_MARGIN;
      addChild(this.progress);
      this.okButton.width = BUTTON_WIDTH;
      this.okButton.addEventListener(MouseEvent.CLICK,this.onClick);
      this.okButton.y = this.progress.y + this.progress.height + VERTICAL_MARGIN;
      addChild(this.okButton);
      lobbyLayoutService.addEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.endSwitch);
      this.updateWidth();
      this.update();
    }

    private function getUpgradableProperties(param1:Vector.<UpgradableItemPropertyValue>) : Vector.<UpgradableItemPropertyValue> {
      var local2:Vector.<UpgradableItemPropertyValue> = new Vector.<UpgradableItemPropertyValue>();
      var local3:int = 0;
      while(local3 < param1.length) {
        if(param1[local3].isUpgradable() || param1[local3].isVisibleInInfo()) {
          local2.push(param1[local3]);
        }
        local3++;
      }
      return local2;
    }

    private function updateWidth() : void {
      var local1:int = Math.max(200,this.infos[0].getWidth());
      this.inner.width = local1;
      this.progress.width = local1;
      width = local1 + 25;
    }

    private function update() : void {
      var local1:UpgradeInfoForm = null;
      if(this.upgradableItemParams.isFullUpgraded()) {
        removeChild(this.okButton);
        this.okButton.removeEventListener(MouseEvent.CLICK,this.onClick);
        this.okButton = null;
        height = this.progress.y + this.progress.height + VERTICAL_MARGIN * 2 + cancelButton.height + 5;
        this.updateWidth();
      } else {
        this.okButton.x = width - this.okButton.width >> 1;
        if(this.upgradableItemParams.isUpgrading()) {
          this.setTimer(this.upgradableItemParams.timer);
        }
        this.updateCrystalButton();
      }
      this.progress.update();
      for each(local1 in this.infos) {
        local1.updateForm();
      }
      dialogService.centerDialog(this);
    }

    public function openDialog() : void {
      dialogService.addDialog(this);
    }

    private function setTimer(param1:CountDownTimer) : void {
      this.removeTimer();
      this.timer = param1;
      this.progress.setTimer(param1);
      param1.addListener(CountDownTimerOnTick,this);
    }

    private function removeTimer() : void {
      if(this.timer != null) {
        this.timer.removeListener(CountDownTimerOnTick,this);
        this.timer = null;
      }
    }

    private function endSwitch(param1:LobbyLayoutServiceEvent) : void {
      this.updateCrystalButton();
    }

    private function updateCrystalButton() : void {
      if(this.upgradableItemParams.isUpgrading()) {
        this.okButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_SPEED_UP_TEXT));
        this.okButton.setSkin(GoldBigButtonSkin.GOLD_SKIN);
        this.okButton.setCost(this.upgradableItemParams.getSpeedUpPrice());
        this.okButton.setSale(this.upgradableItemParams.hasSpeedUpDiscount());
      } else {
        this.okButton.setText(localeService.getText(TanksLocale.TEXT_GARAGE_UPGRADE_TEXT));
        this.okButton.setSkin(GreyBigButtonSkin.GREY_SKIN);
        this.okButton.setCost(this.upgradableItemParams.getStartUpgradePrice());
        this.okButton.setSale(this.upgradableItemParams.hasUpgradeDiscount());
      }
    }

    private function onClick(param1:MouseEvent) : void {
      if(this.upgradableItemParams.isUpgrading()) {
        this.speedUp();
        return;
      }
      this.startUpgrade();
    }

    private function speedUp() : void {
      var local2:CountDownTimer = null;
      var local1:int = int(this.okButton.getPrice());
      if(moneyService.checkEnough(local1)) {
        this.okButton.enabled = false;
        local2 = this.timer;
        this.removeTimer();
        dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SPEED_UP,local2,local1));
      } else {
        dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.FLUSH_UPGRADES));
      }
    }

    override protected function onClose() : void {
      this.removeEvents();
      dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.FLUSH_UPGRADES));
      dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.SELECT_WINDOW_CLOSED));
      dialogService.removeDialog(this);
    }

    override protected function removeEvents() : void {
      super.removeEvents();
      lobbyLayoutService.removeEventListener(LobbyLayoutServiceEvent.END_LAYOUT_SWITCH,this.endSwitch);
      if(Boolean(this.okButton)) {
        this.okButton.removeEventListener(MouseEvent.CLICK,this.onClick);
      }
      this.removeTimer();
    }

    private function startUpgrade() : void {
      var local2:CountDownTimer = null;
      var local1:int = int(this.okButton.getPrice());
      if(moneyService.checkEnough(local1)) {
        local2 = new CountDownTimer();
        local2.start(this.upgradableItemParams.getTimeInSeconds() * 1000 + getTimer());
        this.setTimer(local2);
        this.okButton.enabled = false;
        setTimeout(this.enableOkButton,UPGRADE_TIMEOUT_MS);
        dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.UPGRADE_STARTED,local2,local1));
        this.updateCrystalButton();
      } else {
        dispatchEvent(new ItemPropertyUpgradeEvent(ItemPropertyUpgradeEvent.FLUSH_UPGRADES));
      }
    }

    private function enableOkButton() : void {
      if(Boolean(this.okButton)) {
        this.updateCrystalButton();
        this.okButton.enabled = true;
      }
    }

    public function itemUpgraded() : void {
      this.removeTimer();
      this.update();
      setTimeout(this.enableOkButton,UPGRADE_TIMEOUT_MS);
    }

    public function destroy() : void {
      this.removeEvents();
      dialogService.removeDialog(this);
    }

    public function onTick(param1:CountDownTimer) : void {
      this.okButton.setCost(this.upgradableItemParams.getSpeedUpPrice());
    }
  }
}
