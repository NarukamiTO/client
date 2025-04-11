package projects.tanks.clients.fp10.libraries.tanksservices.model {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IFriendsEvents implements IFriends {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IFriendsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isLocal() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IFriends = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IFriends(this.impl[i]);
          result = Boolean(m.isLocal());
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
