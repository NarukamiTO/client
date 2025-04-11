package alternativa.tanks.service.battlecreate {
  import flash.events.IEventDispatcher;

  public interface IBattleCreateFormService extends IEventDispatcher {
    function showForm() : void;
    function hideForm() : void;
    function get battleCreationDisabled() : Boolean;
    function set battleCreationDisabled(param1:Boolean) : void;
  }
}
