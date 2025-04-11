package platform.client.fp10.core.resource {
  import alternativa.types.Long;

  public class ResourceInfo {
    public var type:int;
    public var id:Long;
    public var version:Long;
    public var isLazy:Boolean;

    public function ResourceInfo(param1:int, param2:Long, param3:Long, param4:Boolean) {
      super();
      this.type = param1;
      this.id = param2;
      this.version = param3;
      this.isLazy = param4;
    }

    public function toString() : String {
      return "[ResourceInfo type=" + this.type + ", id=" + this.id + ", version=" + this.version + ", isLazy=" + this.isLazy + "]";
    }
  }
}
