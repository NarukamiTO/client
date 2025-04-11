package alternativa.tanks.services.tankregistry {
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public class TankUsersRegistryServiceImpl implements TankUsersRegistry {
    private const users:Dictionary = new Dictionary();

    private var userList:Vector.<IGameObject>;
    private var userCount:int;
    private var localUser:IGameObject;

    public function TankUsersRegistryServiceImpl() {
      super();
    }

    public function addUser(param1:IGameObject) : void {
      this.userList = null;
      if(!this.users[param1.id]) {
        this.users[param1.id] = param1;
        ++this.userCount;
      }
      if(ITankModel(param1.adapt(ITankModel)).isLocal()) {
        this.localUser = param1;
      }
    }

    public function removeUser(param1:IGameObject) : void {
      this.userList = null;
      if(Boolean(this.users[param1.id])) {
        delete this.users[param1.id];
        --this.userCount;
      }
      if(ITankModel(param1.adapt(ITankModel)).isLocal()) {
        this.localUser = null;
      }
    }

    public function getUserCount() : int {
      return this.userCount;
    }

    public function getUsers() : Vector.<IGameObject> {
      var local1:IGameObject = null;
      if(this.userList == null) {
        this.userList = new Vector.<IGameObject>();
        for each(local1 in this.users) {
          this.userList.push(local1);
        }
      }
      return this.userList;
    }

    public function getUser(param1:Long) : IGameObject {
      return this.users[param1];
    }

    public function getLocalUser() : IGameObject {
      return this.localUser;
    }

    public function existLocalUser() : Boolean {
      return this.localUser != null;
    }
  }
}
