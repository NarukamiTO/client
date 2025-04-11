package alternativa.tanks.gui.payment.controls {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.gui.icons.CrystalIcon;
  import controls.base.LabelBase;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.filters.DropShadowFilter;
  import flash.text.TextFieldAutoSize;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class BonusLabel extends Sprite {
    [Inject]
    public static var localeService:ILocaleService;

    private var crystalsLabel:LabelBase;
    private var textLabel:LabelBase;
    private var crystalBitmap:Bitmap;

    public function BonusLabel() {
      super();
      this.crystalBitmap = CrystalIcon.createSmallInstance();
      this.crystalBitmap.y = 4;
      addChild(this.crystalBitmap);
      this.crystalsLabel = new LabelBase();
      this.crystalsLabel.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      this.crystalsLabel.size = 13;
      this.crystalsLabel.bold = true;
      this.crystalsLabel.autoSize = TextFieldAutoSize.LEFT;
      addChild(this.crystalsLabel);
      this.textLabel = new LabelBase();
      this.textLabel.filters = [new DropShadowFilter(1,45,0,0.7,1,1,1)];
      this.textLabel.size = 13;
      this.textLabel.bold = true;
      this.textLabel.autoSize = TextFieldAutoSize.LEFT;
      this.textLabel.text = localeService.getText(TanksLocale.TEXT_PAYMENT_PRESENT_LABEL_TEXT);
      addChild(this.textLabel);
    }

    public function setCrystals(param1:int) : void {
      this.crystalsLabel.text = "+" + param1.toString();
      this.draw();
    }

    private function draw() : void {
      var local1:int = this.crystalsLabel.width + this.crystalBitmap.width;
      if(this.textLabel.width > local1) {
        local1 = this.textLabel.width;
      }
      this.crystalsLabel.x = (local1 - this.crystalsLabel.width - this.crystalBitmap.width) * 0.5;
      this.crystalBitmap.x = this.crystalsLabel.x + this.crystalsLabel.width;
      this.textLabel.y = this.crystalsLabel.height - 5;
      this.textLabel.x = (local1 - this.textLabel.width) * 0.5;
    }
  }
}
