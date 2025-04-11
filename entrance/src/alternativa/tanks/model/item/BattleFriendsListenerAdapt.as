package alternativa.tanks.model.item {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleFriendsListenerAdapt implements BattleFriendsListener {
    private var object:IGameObject;
    private var impl:BattleFriendsListener;

    public function BattleFriendsListenerAdapt(param1:IGameObject, param2:BattleFriendsListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onAddFriend(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.onAddFriend(userId);
      }
      finally {
        Model.popObject();
      }
    }

    public function onDeleteFriend(param1:Long) : void {
      var userId:Long = param1;
      try {
        Model.object = this.object;
        this.impl.onDeleteFriend(userId);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
