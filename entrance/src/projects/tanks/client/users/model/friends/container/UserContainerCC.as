package projects.tanks.client.users.model.friends.container {
  import alternativa.types.Long;

  public class UserContainerCC {
    private var _users:Vector.<Long>;

    public function UserContainerCC(param1:Vector.<Long> = null) {
      super();
      this._users = param1;
    }

    public function get users() : Vector.<Long> {
      return this._users;
    }

    public function set users(param1:Vector.<Long>) : void {
      this._users = param1;
    }

    public function toString() : String {
      var local1:String = "UserContainerCC [";
      local1 += "users = " + this.users + " ";
      return local1 + "]";
    }
  }
}
