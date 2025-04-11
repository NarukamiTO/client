package alternativa.tanks.model.quest.common.gui.window.buttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.service.money.IMoneyListener;
  import alternativa.tanks.service.money.IMoneyService;
  import assets.Diamond;
  import controls.Money;
  import controls.base.ThreeLineBigButton;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Sprite;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class DailyQuestChangeButton extends ThreeLineBigButton implements IMoneyListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var moneyService:IMoneyService;

    private static const NOT_ENOUGH_CRYSTALS_TEXT_COLOR:int = 16731648;
    private static const ENOUGH_CRYSTALS_TEXT_COLOR:int = 16777215;

    private var priceLabel:MouseDisabledLabel;
    private var crystals:int;

    public function DailyQuestChangeButton() {
      super();
      this.priceLabel = new MouseDisabledLabel();
      this.priceLabel.size = 11;
      super.setText(localeService.getText(TanksLocale.TEXT_DAILY_QUEST_CHANGE));
      moneyService.addListener(this);
    }

    public function showButtonWithCrystals(param1:int) : void {
      this.crystals = param1;
      var local2:Diamond = new Diamond();
      local2.y = 3;
      var local3:Sprite = new Sprite();
      local3.addChild(this.priceLabel);
      local3.addChild(local2);
      addChild(local3);
      this.priceLabel.text = Money.numToString(param1,false);
      this.priceLabel.x = int(_width / 2 - (this.priceLabel.width + local2.width) / 2);
      local2.x = this.priceLabel.x + this.priceLabel.textWidth + 7;
      this.updatePriceLabelColor();
      super.showInTwoRows(captionLabel,local3);
    }

    public function showButtonWithoutCrystals() : void {
      super.showInOneRow(captionLabel);
    }

    public function crystalsChanged(param1:int) : void {
      this.updatePriceLabelColor();
    }

    private function updatePriceLabelColor() : void {
      this.priceLabel.textColor = moneyService.crystal < this.crystals ? uint(NOT_ENOUGH_CRYSTALS_TEXT_COLOR) : uint(ENOUGH_CRYSTALS_TEXT_COLOR);
    }

    public function removeListeners() : void {
      moneyService.removeListener(this);
    }
  }
}
