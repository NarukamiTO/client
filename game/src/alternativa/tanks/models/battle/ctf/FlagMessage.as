package alternativa.tanks.models.battle.ctf {
  import alternativa.osgi.service.locale.ILocaleService;

  public class FlagMessage {
    [Inject]
    public static var localeService:ILocaleService;

    public var text:String;
    public var color:uint;

    public function FlagMessage(param1:String, param2:uint) {
      super();
      this.text = param1;
      this.color = param2;
    }

    public static function fromTextId(param1:String, param2:uint) : FlagMessage {
      return new FlagMessage(localeService.getText(param1),param2);
    }
  }
}
