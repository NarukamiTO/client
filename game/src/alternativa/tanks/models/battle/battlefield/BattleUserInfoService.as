package alternativa.tanks.models.battle.battlefield {
  import alternativa.types.Long;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public interface BattleUserInfoService {
    function getUserName(param1:Long) : String;
    function getUserRank(param1:Long) : int;
    function isUserSuspected(param1:Long) : Boolean;
    function getChatModeratorLevel(param1:Long) : ChatModeratorLevel;
    function hasUserPremium(param1:Long) : Boolean;
    function addBattleUserInfoListener(param1:BattleUserInfoListener) : void;
    function removeBattleUserInfoListener(param1:BattleUserInfoListener) : void;
  }
}
