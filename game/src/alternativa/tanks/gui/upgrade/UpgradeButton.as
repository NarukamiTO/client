package alternativa.tanks.gui.upgrade {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.crystalbutton.CrystalButton;
  import alternativa.tanks.model.item.upgradable.UpgradableItem;
  import alternativa.tanks.service.item.ItemService;
  import controls.buttons.h50px.GreyBigButtonSkin;
  import controls.labels.CountDownTimerLabel;
  import controls.timer.CountDownTimer;
  import controls.timer.CountDownTimerOnCompleteAfter;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormatAlign;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class UpgradeButton extends CrystalButton implements CountDownTimerOnCompleteAfter {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var itemService:ItemService;

    private static const MARGIN:* = 11;
    private static const WIDTH:* = 120;

    protected var showOnlyCaption:Boolean;

    private var timerLabel:CountDownTimerLabel = new CountDownTimerLabel();
    private var timer:CountDownTimer;

    public function UpgradeButton() {
      this.timerLabel.align = TextFormatAlign.CENTER;
      this.timerLabel.autoSize = TextFieldAutoSize.NONE;
      this.timerLabel.selectable = false;
      this.timerLabel.height = 24;
      this.timerLabel.size = 12;
      this.timerLabel.visible = false;
      super();
      infoContainer.addChild(this.timerLabel);
      crystalLabel.visible = false;
    }

    public function update(param1:IGameObject) : * {
      this.updateUpgradeButton(param1);
      this.setButtonsPosition();
    }

    private function setButtonsPosition() : void {
      x = MARGIN + WIDTH + 15;
    }

    public function setUpgradeButton(param1:Boolean) : void {
      setText(localeService.getText(TanksLocale.TEXT_GARAGE_UPGRADE_TEXT));
      setSkin(GreyBigButtonSkin.GREY_SKIN);
      setSale(param1);
      this.showOnlyCaption = true;
      this.show();
    }

    public function setUpgradedButton() : void {
      setText(localeService.getText(TanksLocale.TEXT_BATTLE_UPGRADES_TEXT));
      setSkin(GreyBigButtonSkin.GREY_SKIN);
      setSale(false);
      this.showOnlyCaption = true;
      this.show();
    }

    public function setUpgradingButton(param1:CountDownTimer, param2:Boolean = false) : void {
      this.startTimer(param1);
      setSale(param2);
      setText(localeService.getText(TanksLocale.TEXT_BATTLE_UPGRADES_TEXT));
      this.showOnlyCaption = false;
      this.show();
    }

    override protected function show() : void {
      if(this.showOnlyCaption) {
        this.timerLabel.visible = false;
        showInOneRow(captionLabel);
      } else {
        this.timerLabel.visible = true;
        showInTwoRows(captionLabel,this.timerLabel);
      }
    }

    override public function set visible(param1:Boolean) : void {
      super.visible = param1;
    }

    public function startTimer(param1:CountDownTimer) : void {
      if(this.timer != null) {
        this.timer.removeListener(CountDownTimerOnCompleteAfter,this);
      }
      this.timer = param1;
      if(param1.getRemainingSeconds() > 0) {
        this.showTime();
        param1.addListener(CountDownTimerOnCompleteAfter,this);
      }
    }

    private function updateUpgradeButton(param1:IGameObject) : void {
      var local2:UpgradableItem = null;
      if(param1.hasModel(UpgradableItem)) {
        local2 = UpgradableItem(param1.adapt(UpgradableItem));
        if(local2.isUpgrading()) {
          this.setUpgradingButton(local2.getCountDownTimer(),local2.hasSpeedUpDiscount());
        } else if(itemService.isFullUpgraded(param1)) {
          this.setUpgradedButton();
        } else {
          this.setUpgradeButton(local2.hasUpgradeDiscount());
        }
      }
    }

    private function showTime() : void {
      this.timerLabel.width = int(width) - 4;
      this.timerLabel.visible = true;
      this.timerLabel.start(this.timer);
      this.resize();
    }

    private function resize() : void {
      if(this.timerLabel.visible) {
        _label.y = 8;
      } else {
        _label.y = 15;
      }
    }

    public function hideTime() : void {
      if(this.timer != null) {
        this.timer.removeListener(CountDownTimerOnCompleteAfter,this);
        this.timer = null;
      }
      this.timerLabel.visible = false;
      this.timerLabel.stop();
      this.resize();
    }

    public function onCompleteAfter(param1:CountDownTimer, param2:Boolean) : void {
      this.hideTime();
    }
  }
}
