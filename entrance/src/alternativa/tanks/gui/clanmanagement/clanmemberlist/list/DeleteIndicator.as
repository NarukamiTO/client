package alternativa.tanks.gui.clanmanagement.clanmemberlist.list {
  import alternativa.tanks.gui.clanmanagement.clanmemberlist.IClanActionListener;
  import alternativa.tanks.models.clan.membersdata.ClanMembersDataService;
  import alternativa.tanks.models.foreignclan.ForeignClanService;
  import alternativa.types.Long;
  import base.DiscreteSprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import projects.tanks.client.clans.clan.permissions.ClanAction;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.clan.ClanUserInfoService;

  public class DeleteIndicator extends DiscreteSprite implements IClanActionListener {
    [Inject]
    public static var clanUserInfoService:ClanUserInfoService;

    [Inject]
    public static var clanMembersData:ClanMembersDataService;

    [Inject]
    public static var foreignClanService:ForeignClanService;

    private static var deleteIconClass:Class = DeleteIndicator_deleteIconClass;
    private static var deleteIconBitmapData:BitmapData = Bitmap(new deleteIconClass()).bitmapData;

    private var invisible:Boolean;
    private var userId:Long;
    private var currentUserId:Long;

    public function DeleteIndicator(param1:Boolean = false, param2:Long = null, param3:Long = null) {
      super();
      this.userId = param2;
      this.currentUserId = param3;
      this.tabChildren = false;
      this.tabEnabled = false;
      this.buttonMode = this.useHandCursor = true;
      this.invisible = param1;
      var local4:Bitmap = new Bitmap(deleteIconBitmapData);
      addChild(local4);
    }

    public function updateActions() : void {
      visible = !this.invisible && clanUserInfoService.hasAction(ClanAction.REMOVE_FROM_CLAN) && this.deleteAllowed() && !foreignClanService.isShowForeignClan();
    }

    private function deleteAllowed() : Boolean {
      if(this.userId == null || this.currentUserId == null) {
        return true;
      }
      return clanMembersData.getPermission(this.currentUserId).value < clanMembersData.getPermission(this.userId).value;
    }
  }
}
