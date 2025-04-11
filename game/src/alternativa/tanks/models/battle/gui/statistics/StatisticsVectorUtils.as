package alternativa.tanks.models.battle.gui.statistics {
  import alternativa.types.Long;
  import flash.utils.Dictionary;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.client.battleservice.model.statistics.UserInfo;
  import projects.tanks.client.battleservice.model.statistics.UserReward;
  import projects.tanks.client.battleservice.model.statistics.UserStat;

  public class StatisticsVectorUtils {
    public function StatisticsVectorUtils() {
      super();
    }

    public static function createUsersStat(param1:Dictionary, param2:Vector.<UserInfo>) : Vector.<ClientUserStat> {
      var local6:UserInfo = null;
      var local7:ClientUserStat = null;
      var local3:Vector.<ClientUserStat> = new Vector.<ClientUserStat>();
      var local4:int = int(param2.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = param2[local5];
        local7 = new ClientUserStat();
        local7.initUserInfo(local6,param1[local6.user]);
        local3.push(local7);
        local5++;
      }
      return local3;
    }

    public static function refreshUsersStat(param1:Dictionary, param2:Vector.<UserStat>) : Vector.<ClientUserStat> {
      var local6:UserStat = null;
      var local7:ClientUserStat = null;
      var local3:Vector.<ClientUserStat> = new Vector.<ClientUserStat>();
      var local4:int = int(param2.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = param2[local5];
        local7 = new ClientUserStat();
        local7.initUserStat(local6,param1[local6.user]);
        local3.push(local7);
        local5++;
      }
      return local3;
    }

    public static function createClientUserInfo(param1:UserInfo, param2:BattleTeam) : ClientUserInfo {
      return new ClientUserInfo(param1.user,param1.uid,param1.rank,false,false,param2,param1.chatModeratorLevel,param1.hasPremium);
    }

    public static function getUserInfo(param1:Long, param2:Vector.<UserInfo>) : UserInfo {
      var local5:UserInfo = null;
      var local3:int = int(param2.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param2[local4];
        if(param1 == local5.user) {
          return local5;
        }
        local4++;
      }
      return null;
    }

    public static function deleteUserStat(param1:Vector.<ClientUserStat>, param2:Long) : Vector.<ClientUserStat> {
      var local6:ClientUserStat = null;
      var local3:Vector.<ClientUserStat> = new Vector.<ClientUserStat>();
      var local4:int = int(param1.length);
      var local5:int = 0;
      while(local5 < local4) {
        local6 = param1[local5];
        if(local6.userId != param2) {
          local3.push(local6);
        }
        local5++;
      }
      return local3;
    }

    public static function updateReward(param1:Vector.<ClientUserStat>, param2:Vector.<UserReward>) : void {
      var local5:UserReward = null;
      var local6:ClientUserStat = null;
      var local3:int = int(param2.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param2[local4];
        local6 = getClientUserStat(param1,local5.userId);
        if(local6 != null) {
          local6.reward = local5.reward + local5.premiumBonusReward + local5.newbiesAbonementBonusReward;
          local6.stars = local5.starsReward;
        }
        local4++;
      }
    }

    public static function getClientUserStat(param1:Vector.<ClientUserStat>, param2:Long) : ClientUserStat {
      var local5:ClientUserStat = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        if(local5.userId == param2) {
          return local5;
        }
        local4++;
      }
      return null;
    }

    public static function changeUserStat(param1:Vector.<ClientUserStat>, param2:UserStat) : ClientUserStat {
      var local5:ClientUserStat = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        if(local5.userId == param2.user) {
          local5.updateUserStat(param2);
          return local5;
        }
        local4++;
      }
      return null;
    }

    public static function getRewardById(param1:Long, param2:Vector.<UserReward>) : UserReward {
      var local5:UserReward = null;
      var local3:int = int(param2.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param2[local4];
        if(param1 == local5.userId) {
          return local5;
        }
        local4++;
      }
      return null;
    }

    public static function getUserPosition(param1:Vector.<ClientUserStat>, param2:Long) : int {
      var local5:ClientUserStat = null;
      var local3:int = int(param1.length);
      var local4:int = 0;
      while(local4 < local3) {
        local5 = param1[local4];
        if(local5.userId == param2) {
          return local4;
        }
        local4++;
      }
      return -1;
    }
  }
}
