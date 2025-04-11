package services.buttonbar {
  import flash.events.IEventDispatcher;

  public interface IButtonBarService extends IEventDispatcher {
    function change(param1:int) : void;
  }
}
