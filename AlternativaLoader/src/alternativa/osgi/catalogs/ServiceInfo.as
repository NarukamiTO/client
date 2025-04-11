package alternativa.osgi.catalogs {
  public class ServiceInfo {
    public var service:Object;
    public var params:Vector.<ServiceParam>;

    public function ServiceInfo(param1:Object, param2:Vector.<ServiceParam>) {
      super();
      this.service = param1;
      this.params = param2;
    }
  }
}
