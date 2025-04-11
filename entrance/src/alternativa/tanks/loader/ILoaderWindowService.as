package alternativa.tanks.loader {
  import flash.events.IEventDispatcher;

  public interface ILoaderWindowService extends IEventDispatcher {
    function show() : void;
    function showDelayed(param1:int) : void;
    function hide() : void;
    function hideForcibly() : void;
    function isInProgress() : Boolean;
  }
}
