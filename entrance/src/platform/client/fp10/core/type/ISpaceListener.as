package platform.client.fp10.core.type {
  public interface ISpaceListener {
    function objectCreated(param1:IGameObject) : void;
    function objectDestroyed(param1:IGameObject) : void;
    function spaceClosed() : void;
  }
}
