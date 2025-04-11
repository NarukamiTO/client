package platform.client.fp10.core.network.connection {
  public class ConnectionStatus {
    public static const IDLE:ConnectionStatus = new ConnectionStatus("IDLE");
    public static const CONNECTING:ConnectionStatus = new ConnectionStatus("CONNECTING");
    public static const CONNECTED:ConnectionStatus = new ConnectionStatus("CONNECTED");
    public static const DISCONNECTED:ConnectionStatus = new ConnectionStatus("DISCONNECTED");

    private var _value:String;

    public function ConnectionStatus(param1:String) {
      super();
      this._value = param1;
    }

    public function toString() : String {
      return this._value;
    }
  }
}
