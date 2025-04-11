package alternativa.tanks.models.clan.permission {
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  [ModelInterface]
  public interface IClanPermissionsModel {
    function setPosition(param1:Long, param2:ClanPermission) : void;
  }
}
