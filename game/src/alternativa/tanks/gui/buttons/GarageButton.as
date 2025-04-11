package alternativa.tanks.gui.buttons {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.crystalbutton.CrystalLabel;
  import alternativa.tanks.gui.icons.PremiumIcon;
  import alternativa.tanks.service.money.IMoneyListener;
  import alternativa.tanks.service.money.IMoneyService;
  import base.DiscreteSprite;
  import controls.base.ThreeLineBigButton;
  import controls.labels.MouseDisabledLabel;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import forms.events.FormEvent;
  import forms.ranks.SmallRankIcon;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.premium.PremiumService;

  public class GarageButton extends ThreeLineBigButton implements IMoneyListener {
    [Inject]
    public static var localeService:ILocaleService;

    [Inject]
    public static var moneyService:IMoneyService;

    [Inject]
    public static var premiumService:PremiumService;

    private var secondRow:Sprite = new DiscreteSprite();
    private var fullPriceLabel:CrystalLabel = new CrystalLabel();
    private var rankLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var rankIcon:SmallRankIcon = new SmallRankIcon();
    private var premiumIcon:Bitmap = PremiumIcon.createSmallInstance();
    private var thirdRow:Sprite = new DiscreteSprite();
    private var priceLabel:CrystalLabel = new CrystalLabel();
    private var discountLabel:MouseDisabledLabel = new MouseDisabledLabel();
    private var price:int;

    public function GarageButton(param1:int = 120) {
      super();
      this.width = param1;
      addEventListener(FormEvent.FORM_DESTOY,this.onDestroy);
      moneyService.addListener(this);
      this.priceLabel.setSharpness(-100);
      this.priceLabel.setThickness(100);
      this.fullPriceLabel.setSharpness(-100);
      this.fullPriceLabel.setThickness(100);
      this.rankLabel.color = 16731648;
      this.rankLabel.sharpness = -100;
      this.rankLabel.thickness = 100;
      this.secondRow.addChild(this.fullPriceLabel);
      this.secondRow.addChild(this.rankLabel);
      this.rankIcon.y = 3;
      this.secondRow.addChild(this.rankIcon);
      this.premiumIcon.y = 4;
      this.secondRow.addChild(this.premiumIcon);
      this.rankLabel.text = localeService.getText(TanksLocale.TEXT_GARAGE_BUY_BUTTON_RANK_LABEL);
      this.thirdRow.addChild(this.priceLabel);
      this.thirdRow.addChild(this.discountLabel);
      infoContainer.addChild(this.secondRow);
      infoContainer.addChild(this.thirdRow);
      addChild(infoContainer);
    }

    public function setInfo(param1:int, param2:int = 1, param3:int = 0, param4:Boolean = false) : void {
      param1 *= param2;
      this.price = param1;
      var local5:int = param1;
      this.updateCrystalColor();
      this.fullPriceLabel.setCost(local5);
      this.label = "";
      infoContainer.visible = true;
      infoContainer.x = 0;
      captionLabel.x = (_width - captionLabel.width) * 0.5;
      if(param3 < 0) {
        param3 = -param3;
        this.rankIcon.init(param4 && !premiumService.hasPremium(),param3);
        this.fullPriceLabel.x = (_width - (this.fullPriceLabel.width + this.rankLabel.width + this.rankIcon.width + 4 - 1)) * 0.5;
        this.rankLabel.x = this.fullPriceLabel.x + this.fullPriceLabel.width + 5;
        this.rankIcon.x = this.rankLabel.x + this.rankLabel.width;
        this.rankIcon.visible = true;
        this.rankLabel.visible = true;
        this.premiumIcon.visible = false;
        enabled = false;
      } else {
        this.rankLabel.visible = false;
        this.rankIcon.visible = false;
        enabled = !param4 || Boolean(premiumService.hasPremium());
        this.premiumIcon.visible = !enabled;
        this.fullPriceLabel.x = (_width - this.fullPriceLabel.width - (this.premiumIcon.visible ? this.premiumIcon.width : 0)) * 0.5;
        this.premiumIcon.x = this.fullPriceLabel.x + this.fullPriceLabel.width + 5;
      }
      this.showTwoRows();
    }

    private function updateCrystalColor() : void {
      if(moneyService.crystal < this.price) {
        this.priceLabel.setColor(16731648);
        this.fullPriceLabel.setColor(16731648);
      } else if(this.price == 0) {
        this.priceLabel.setColor(11206400);
        this.fullPriceLabel.setColor(11206400);
      } else {
        this.fullPriceLabel.setColor(16777215);
        this.priceLabel.setColor(16777215);
      }
    }

    private function showTwoRows() : void {
      this.thirdRow.visible = false;
      super.showInTwoRows(captionLabel,this.secondRow);
    }

    private function showThreeRows() : void {
      this.thirdRow.visible = true;
      super.showInThreeRows(captionLabel,this.secondRow,this.thirdRow);
    }

    public function crystalsChanged(param1:int) : void {
      this.updateCrystalColor();
    }

    protected function onDestroy(param1:FormEvent) : void {
      moneyService.removeListener(this);
      removeEventListener(FormEvent.FORM_DESTOY,this.onDestroy);
    }
  }
}
