package alternativa.tanks.gui.clanmanagement {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.ContextMenuPermissionLabel;
  import alternativa.types.Long;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;

  public class PermissionLabel extends ContextMenuPermissionLabel {
    public function PermissionLabel(param1:ClanPermission, param2:Object, param3:Long, param4:Long) {
      super(param1);
      this.data = param2;
      this.id = param3;
      this.currentUserId = param4;
      this.contextItem = false;
      ClanPermissionsManager.addPositionUpdateListener(this);
    }
  }
}
