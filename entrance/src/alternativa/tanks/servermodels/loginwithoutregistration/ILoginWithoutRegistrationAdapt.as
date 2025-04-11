package alternativa.tanks.servermodels.loginwithoutregistration {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILoginWithoutRegistrationAdapt implements ILoginWithoutRegistration {
    private var object:IGameObject;
    private var impl:ILoginWithoutRegistration;

    public function ILoginWithoutRegistrationAdapt(param1:IGameObject, param2:ILoginWithoutRegistration) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function passToFirstBattle() : void {
      try {
        Model.object = this.object;
        this.impl.passToFirstBattle();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
