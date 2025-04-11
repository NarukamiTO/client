package projects.tanks.client.tanksservices.model.reconnect {
  public class RemoteEndpointData {
    private var _host:String;
    private var _ports:Vector.<int>;

    public function RemoteEndpointData(param1:String = null, param2:Vector.<int> = null) {
      super();
      this._host = param1;
      this._ports = param2;
    }

    public function get host() : String {
      return this._host;
    }

    public function set host(param1:String) : void {
      this._host = param1;
    }

    public function get ports() : Vector.<int> {
      return this._ports;
    }

    public function set ports(param1:Vector.<int>) : void {
      this._ports = param1;
    }

    public function toString() : String {
      var local1:String = "RemoteEndpointData [";
      local1 += "host = " + this.host + " ";
      local1 += "ports = " + this.ports + " ";
      return local1 + "]";
    }
  }
}
