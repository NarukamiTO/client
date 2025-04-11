package platform.client.fp10.core.network.connection {
  public class ConnectionCloseStatus {
    public static const CLOSED_BY_SERVER:ConnectionCloseStatus = new ConnectionCloseStatus("CLOSED_BY_SERVER","Connection closed by server");
    public static const CONNECTION_ERROR:ConnectionCloseStatus = new ConnectionCloseStatus("CONNECTION_ERROR","Connection error");
    public static const DATA_PROCESSING_ERROR:ConnectionCloseStatus = new ConnectionCloseStatus("DATA_PROCESSING_ERROR","Data processing error");
    public static const SPACE_CLOSED:ConnectionCloseStatus = new ConnectionCloseStatus("SPACE_CLOSED","Space closed");
    public static const CLOSED_BY_CLIENT:ConnectionCloseStatus = new ConnectionCloseStatus("CLOSED_BY_CLIENT","Connection closed by client");

    private var _value:String;
    private var _defaultMessage:String;

    public function ConnectionCloseStatus(param1:String, param2:String) {
      super();
      this._value = param1;
      this._defaultMessage = param2;
    }

    public function toString() : String {
      return this._value;
    }

    public function get defaultMessage() : String {
      return this._defaultMessage;
    }
  }
}
