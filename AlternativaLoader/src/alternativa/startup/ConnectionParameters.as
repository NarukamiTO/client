package alternativa.startup {
  public class ConnectionParameters {
    public var serverAddress:String;
    public var serverPorts:Vector.<int>;
    public var resourcesRootURL:String;
    public var secure:Boolean;

    public function ConnectionParameters(param1:String, param2:Vector.<int>, param3:String, param4:Boolean) {
      super();
      this.serverAddress = param1;
      this.serverPorts = param2;
      this.resourcesRootURL = param3;
      this.secure = param4;
    }
  }
}
