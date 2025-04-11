package alternativa.tanks.servermodels.invite {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IInviteEvents implements IInvite {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IInviteEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function checkInvite(param1:String) : void {
      var i:int = 0;
      var m:IInvite = null;
      var inviteCode:String = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IInvite(this.impl[i]);
          m.checkInvite(inviteCode);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
