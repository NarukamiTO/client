package alternativa.tanks.models.clan.permission {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public class IClanPermissionsModelEvents implements IClanPermissionsModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IClanPermissionsModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setPosition(param1:Long, param2:ClanPermission) : void {
      var i:int = 0;
      var m:IClanPermissionsModel = null;
      var id:Long = param1;
      var position:ClanPermission = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IClanPermissionsModel(this.impl[i]);
          m.setPosition(id,position);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
