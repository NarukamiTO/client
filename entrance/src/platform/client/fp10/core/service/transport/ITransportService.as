package platform.client.fp10.core.service.transport {
  import flash.utils.ByteArray;
  import platform.client.fp10.core.network.connection.ConnectionInitializers;
  import platform.client.fp10.core.network.connection.IConnection;
  import platform.client.fp10.core.network.handler.ControlCommandHandler;

  public interface ITransportService {
    function createConnection(param1:ConnectionInitializers) : IConnection;
    function get controlCommandHandler() : ControlCommandHandler;
    function get controlConnection() : IConnection;
    function get hash() : ByteArray;
  }
}
