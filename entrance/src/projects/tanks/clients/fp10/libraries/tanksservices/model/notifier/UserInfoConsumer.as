package projects.tanks.clients.fp10.libraries.tanksservices.model.notifier {
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;

  public interface UserInfoConsumer {
    function setOnline(param1:Boolean, param2:int) : void;
    function setUid(param1:String) : void;
    function setRank(param1:int) : void;
    function setBattleUrl(param1:BattleLinkData) : void;
    function setSNUid(param1:String) : void;
    function setIsReferral(param1:Boolean) : void;
  }
}
