package alternativa.tanks.servermodels.invite {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IInviteAdapt implements IInvite {
    private var object:IGameObject;
    private var impl:IInvite;

    public function IInviteAdapt(param1:IGameObject, param2:IInvite) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkInvite(param1:String) : void {
      var inviteCode:String = param1;
      try {
        Model.object = this.object;
        this.impl.checkInvite(inviteCode);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
