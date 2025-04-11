package alternativa.tanks.models.clan.membersdata {
  import alternativa.tanks.gui.clanmanagement.ClanPermissionsManager;
  import alternativa.tanks.models.service.ClanNotificationsManager;
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.clans.clan.clanmembersdata.UserData;
  import projects.tanks.client.clans.clan.permissions.ClanPermission;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.user.IUserInfoService;

  public class ClanMembersDataServiceImpl implements ClanMembersDataService {
    [Inject]
    public static var userInfoService:IUserInfoService;

    private var usersData:Dictionary = new Dictionary();

    public function ClanMembersDataServiceImpl() {
      super();
    }

    public function setData(param1:UserData) : void {
      this.usersData[param1.userId] = param1;
      ClanPermissionsManager.updatePositions(param1);
    }

    public function getKills(param1:Long) : int {
      return this.usersData[param1].kills;
    }

    public function getScore(param1:Long) : int {
      return this.usersData[param1].score;
    }

    public function getDeaths(param1:Long) : int {
      return this.usersData[param1].deaths;
    }

    public function getKillDeathRatio(param1:Long) : Number {
      var local2:Number = Number(this.usersData[param1].deaths);
      var local3:Number = Number(this.usersData[param1].kills);
      if(local2 == 0) {
        return local3;
      }
      return local3 / local2;
    }

    public function getDateInClanInSec(param1:Long) : int {
      return this.usersData[param1].dateInClanInSec;
    }

    public function getPermission(param1:Long) : ClanPermission {
      if(param1 in this.usersData) {
        return this.usersData[param1].permission;
      }
      return ClanPermission.NOVICE;
    }

    public function getLastVisitDateInSec(param1:Long) : Long {
      return this.usersData[param1].lastVisitTime;
    }

    public function getClanMemberData(param1:Long) : Object {
      var local2:Object = {};
      local2.score = this.getScore(param1).toString();
      local2.permission = this.getPermission(param1);
      local2.kills = this.getKills(param1).toString();
      local2.deaths = this.getDeaths(param1).toString();
      local2.score = this.getScore(param1).toString();
      local2.kd = this.getKillDeathRatio(param1).toFixed(2).toString();
      local2.date = this.getDateInClanInSec(param1);
      local2.lastOnlineDate = this.getLastVisitDateInSec(param1);
      local2.id = param1;
      var local3:Long = userInfoService.getCurrentUserId();
      local2.currentUserId = local3;
      local2.currentUserPermission = this.getPermission(local3);
      local2.isNew = ClanNotificationsManager.userInAcceptedNotifications(param1);
      return local2;
    }
  }
}
