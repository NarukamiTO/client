package alternativa.tanks.models.battle.gui.gui.help {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.Bitmap;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.Helper;

  public class ControlsHelper extends Helper {
    [Inject]
    public static var localeService:ILocaleService;

    public static const GROUP_ID:String = "Tank.ControlsHelper";
    public static const HELPER_ID:int = 1;

    private var helpImage:Bitmap;

    public function ControlsHelper() {
      super();
      this.init();
    }

    [Obfuscation(rename="false")]
    override public function align(param1:int, param2:int) : void {
      this.helpImage.x = (param1 - this.helpImage.width) / 2;
      this.helpImage.y = (param2 - this.helpImage.height) / 2;
    }

    private function init() : void {
      this.helpImage = new Bitmap(localeService.getImage(TanksLocale.IMAGE_FULL_BATTLE_HELP));
      addChild(this.helpImage);
      _showLimit = 10;
      showDuration = 8000;
    }
  }
}
