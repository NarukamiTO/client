package platform.client.fp10.core.network {
  import platform.client.fp10.core.network.connection.ConnectionCloseStatus;

  public interface ICommandHandler {
    function onConnectionOpen(param1:ICommandSender) : void;
    function onConnectionClose(param1:ConnectionCloseStatus, param2:String = null) : void;
    function executeCommand(param1:Object) : void;
  }
}
