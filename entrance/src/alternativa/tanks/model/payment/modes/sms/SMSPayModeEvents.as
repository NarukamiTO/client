package alternativa.tanks.model.payment.modes.sms {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.payment.modes.sms.types.Country;

  public class SMSPayModeEvents implements SMSPayMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function SMSPayModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCountries() : Vector.<Country> {
      var result:Vector.<Country> = null;
      var i:int = 0;
      var m:SMSPayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SMSPayMode(this.impl[i]);
          result = m.getCountries();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
