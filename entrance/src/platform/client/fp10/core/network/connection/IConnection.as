package platform.client.fp10.core.network.connection {
  import platform.client.fp10.core.network.ICommandSender;

  public interface IConnection extends ICommandSender {
    function connect(param1:ConnectionConnectParameters) : void;
    function close(param1:ConnectionCloseStatus, param2:String = null) : void;
    function closeConnectionOnTransportError() : void;
  }
}
