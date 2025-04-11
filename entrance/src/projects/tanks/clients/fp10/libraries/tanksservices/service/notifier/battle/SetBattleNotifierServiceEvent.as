package projects.tanks.clients.fp10.libraries.tanksservices.service.notifier.battle {
  import flash.events.Event;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;

  public class SetBattleNotifierServiceEvent extends Event {
    public static const SET_BATTLE:String = "SetBattleNotifierServiceEvent.SET_BATTLE";

    public var users:Vector.<BattleLinkData>;

    public function SetBattleNotifierServiceEvent(param1:String, param2:Vector.<BattleLinkData>, param3:Boolean = false, param4:Boolean = false) {
      this.users = param2;
      super(param1,param3,param4);
    }
  }
}
