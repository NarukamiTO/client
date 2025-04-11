package projects.tanks.clients.fp10.libraries.tanksservices.service.user {
  import flash.events.IEventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.model.notifier.battle.BattleLinkData;

  public interface IUserInfoLabelUpdater extends IEventDispatcher {
    function hasData() : Boolean;
    function get online() : Boolean;
    function get uid() : String;
    function get rank() : int;
    function get battleLink() : BattleLinkData;
    function incrementVisibleLabelsCounter() : void;
    function decrementVisibleLabelsCounter() : void;
    function updateLastAccessTime() : void;
    function hasBattleLink() : Boolean;
    function getSNUid() : String;
    function isReferral() : Boolean;
  }
}
