package projects.tanks.clients.fp10.libraries.tanksservices.model.reconnect {
  public interface ReconnectCallback {
    function onReconnectCancel() : void;
    function onReconnectError() : void;
    function onReconnectStarted() : void;
  }
}
