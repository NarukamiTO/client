package alternativa.tanks.servermodels.emailconfirm {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IEmailConfirmEvents implements IEmailConfirm {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IEmailConfirmEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function startEmailConfirm(param1:String, param2:String) : void {
      var i:int = 0;
      var m:IEmailConfirm = null;
      var emailConfirmHash:String = param1;
      var email:String = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IEmailConfirm(this.impl[i]);
          m.startEmailConfirm(emailConfirmHash,email);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
