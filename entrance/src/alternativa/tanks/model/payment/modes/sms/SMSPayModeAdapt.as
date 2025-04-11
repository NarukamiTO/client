package alternativa.tanks.model.payment.modes.sms {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;

  public class SMSPayModeAdapt implements SMSPayMode {
    private var object:IGameObject;
    private var impl:SMSPayMode;

    public function SMSPayModeAdapt(param1:IGameObject, param2:SMSPayMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCountries() : Vector.<Country> {
      var result:Vector.<Country> = null;
      try {
        Model.object = this.object;
        result = this.impl.getCountries();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
