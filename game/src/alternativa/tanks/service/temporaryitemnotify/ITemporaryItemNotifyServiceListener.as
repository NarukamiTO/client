package alternativa.tanks.service.temporaryitemnotify {
  import platform.client.fp10.core.type.IGameObject;

  public interface ITemporaryItemNotifyServiceListener {
    function temporaryItemTimeIsUp(param1:IGameObject) : void;
  }
}
