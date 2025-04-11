package alternativa.tanks.gui.payment.controls {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.icons.PremiumIcon;
  import base.DiscreteSprite;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.filters.DropShadowFilter;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class PremiumLabel extends DiscreteSprite {
    [Inject]
    public static var localeService:ILocaleService;

    private var premiumIcon:Bitmap;
    private var durationLabel:LabelBase;

    public function PremiumLabel() {
      super();
      this.premiumIcon = PremiumIcon.createInstance();
      this.premiumIcon.y = localeService.language == "cn" ? 0 : 2;
      this.premiumIcon.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      addChild(this.premiumIcon);
      this.durationLabel = new LabelBase();
      this.durationLabel.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      this.durationLabel.size = 14;
      this.durationLabel.bold = true;
      addChild(this.durationLabel);
    }

    public function setPremiumDuration(param1:int) : void {
      this.durationLabel.text = "+" + param1 + localeService.getText(TanksLocale.TEXT_TIME_LABEL_DAY) + " ";
      this.draw();
    }

    private function draw() : void {
      this.premiumIcon.x = this.durationLabel.width;
    }
  }
}
