package projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite {
  import flash.events.Event;

  public class BattleInviteEnableEvent extends Event {
    public static const UPDATE:String = "BattleInviteEnableEvent.UPDATE";

    public var enable:Boolean;

    public function BattleInviteEnableEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false) {
      super(param1,param3,param4);
      this.enable = param2;
    }
  }
}
