package platform.client.fp10.core.network.connection {
  public class ConnectionConnectParameters {
    private var _host:String;
    private var _ports:Vector.<int>;

    public function ConnectionConnectParameters(param1:String, param2:Vector.<int>) {
      super();
      this._host = param1;
      this._ports = param2;
    }

    public function get host() : String {
      return this._host;
    }

    public function get ports() : Vector.<int> {
      return this._ports;
    }

    public function toString() : String {
      return "[host=" + String(this._host) + " ports=" + String(this._ports) + "]";
    }
  }
}
