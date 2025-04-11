package alternativa.tanks.models.battle.gui.gui.statistics.field.fund {
  import alternativa.osgi.service.locale.ILocaleService;
  import alternativa.tanks.models.battle.gui.gui.statistics.field.IconField;
  import assets.Diamond;
  import controls.Money;
  import flash.display.DisplayObject;
  import projects.tanks.clients.fp10.libraries.TanksLocale;

  public class FundField extends IconField {
    [Inject]
    public static var localeService:ILocaleService;

    private var diamond:Diamond = new Diamond();

    public function FundField(param1:DisplayObject) {
      super(param1);
    }

    override protected function init() : void {
      super.init();
      addChild(this.diamond);
      this.diamond.y = 4;
      this.update();
    }

    public function initFund(param1:int) : void {
      var local2:String = localeService.getText(TanksLocale.TEXT_BATTLE_FUND);
      label.text = local2 + ": " + Money.numToString(param1,false);
      this.update();
    }

    private function update() : void {
      this.diamond.x = label.x + label.width + 2;
    }
  }
}
