package platform.client.fp10.core.network.handler {
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;

  public interface OnConnectionClosedServiceListener {
    function onConnectionClosed(param1:ConnectionCloseStatus) : void;
  }
}
