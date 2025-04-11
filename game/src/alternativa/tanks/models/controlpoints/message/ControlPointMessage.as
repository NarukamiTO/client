package alternativa.tanks.models.controlpoints.message {
  import alternativa.osgi.service.locale.ILocaleService;

  public class ControlPointMessage {
    [Inject]
    public static var localeService:ILocaleService;

    public var color:uint;

    private var localizedStringKey:String;

    public function ControlPointMessage(param1:uint, param2:String) {
      super();
      this.color = param1;
      this.localizedStringKey = param2;
    }

    public function getMessage(param1:String) : String {
      return localeService.getText(this.localizedStringKey).replace("{point}",param1);
    }
  }
}
