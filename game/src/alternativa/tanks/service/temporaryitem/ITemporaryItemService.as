package alternativa.tanks.service.temporaryitem {
  import platform.client.fp10.core.type.IGameObject;

  public interface ITemporaryItemService {
    function getCurrentTimeRemainingMSec(param1:IGameObject) : Number;
    function startItem(param1:IGameObject, param2:int) : void;
    function stopItem(param1:IGameObject) : void;
  }
}
