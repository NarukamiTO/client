package alternativa.tanks.models.battle.gui.gui.help {
  import alternativa.osgi.service.locale.ILocaleService;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import projects.tanks.clients.fp10.libraries.TanksLocale;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.helper.IHelpService;

  public class ControlsMiniHelp extends Sprite {
    [Inject]
    public static var helpService:IHelpService;

    [Inject]
    public static var localeService:ILocaleService;

    private var normalHelp:Bitmap;
    private var mouseHelp:Bitmap;

    public function ControlsMiniHelp() {
      super();
      this.normalHelp = new Bitmap(localeService.getImage(TanksLocale.IMAGE_HELP_CONTROLS_MINI));
      this.mouseHelp = new Bitmap(localeService.getImage(TanksLocale.IMAGE_HELP_MOUSE_MINI));
      addEventListener(MouseEvent.CLICK,onHelpImageClick);
    }

    private static function onHelpImageClick(param1:MouseEvent) : void {
      helpService.showHelp();
      param1.stopPropagation();
    }

    public function setTargetingMode(param1:int) : void {
    }
  }
}
