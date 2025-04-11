package alternativa.tanks.models.clan.membersdata {
  import platform.client.fp10.core.model.ObjectLoadListener;
  import projects.tanks.client.clans.clan.clanmembersdata.ClanMembersDataModelBase;
  import projects.tanks.client.clans.clan.clanmembersdata.IClanMembersDataModelBase;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;

  [ModelInfo]
  public class ClanMembersDataModel extends ClanMembersDataModelBase implements IClanMembersDataModelBase, ObjectLoadListener {
    [Inject]
    public static var clanMembersService:ClanMembersDataService;

    public function ClanMembersDataModel() {
      super();
    }

    public function objectLoaded() : void {
      var local1:UserData = null;
      for each(local1 in getInitParam().users) {
        clanMembersService.setData(local1);
      }
    }

    public function sendData(param1:UserData) : void {
      clanMembersService.setData(param1);
    }
  }
}
