package alternativa.tanks.servermodels.loginwithoutregistration {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILoginWithoutRegistrationEvents implements ILoginWithoutRegistration {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ILoginWithoutRegistrationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function passToFirstBattle() : void {
      var i:int = 0;
      var m:ILoginWithoutRegistration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILoginWithoutRegistration(this.impl[i]);
          m.passToFirstBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
