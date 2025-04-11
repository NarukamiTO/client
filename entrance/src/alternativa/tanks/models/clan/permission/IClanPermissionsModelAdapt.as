package alternativa.tanks.models.clan.permission {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public class IClanPermissionsModelAdapt implements IClanPermissionsModel {
    private var object:IGameObject;
    private var impl:IClanPermissionsModel;

    public function IClanPermissionsModelAdapt(param1:IGameObject, param2:IClanPermissionsModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setPosition(param1:Long, param2:ClanPermission) : void {
      var id:Long = param1;
      var position:ClanPermission = param2;
      try {
        Model.object = this.object;
        this.impl.setPosition(id,position);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
