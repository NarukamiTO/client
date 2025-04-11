package alternativa.tanks.service.temporaryitemnotify {
  import platform.client.fp10.core.type.IGameObject;

  public interface ITemporaryItemNotifyService {
    function addListener(param1:ITemporaryItemNotifyServiceListener) : void;
    function removeListener(param1:ITemporaryItemNotifyServiceListener) : void;
    function notifyTimeIsUp(param1:IGameObject) : void;
  }
}
