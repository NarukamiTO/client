package alternativa.tanks.models.clan.permission {
  import alternativa.tanks.gui.clanmanagement.ClanActionsManager;
  import alternativa.tanks.gui.clanmanagement.ClanPermissionsManager;
  import alternativa.types.Long;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;
  import projects.tanks.client.clans.clan.permissions.ClanPermissionsModelBase;
  import projects.tanks.client.clans.clan.permissions.IClanPermissionsModelBase;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  [ModelInfo]
  public class ClanPermissionsModel extends ClanPermissionsModelBase implements IClanPermissionsModel, IClanPermissionsModelBase, ObjectLoadListener {
    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    public function ClanPermissionsModel() {
      super();
    }

    public function objectLoaded() : void {
      clanUserInfoService.actions = getInitParam().actions;
      ClanPermissionsManager.permissionsModel = object.adapt(IClanPermissionsModel) as IClanPermissionsModel;
    }

    public function updateActions(param1:Vector.<ClanAction>) : void {
      clanUserInfoService.actions = param1;
      ClanActionsManager.updateActions();
    }

    public function setPosition(param1:Long, param2:ClanPermission) : void {
      server.setPermissionForUser(param1,param2);
    }
  }
}
