package platform.client.fp10.core.resource {
  public class ResourceFileInfo {
    public var fileName:String;
    public var fileSize:int;

    public function ResourceFileInfo(param1:String, param2:int) {
      super();
      this.fileName = param1;
      this.fileSize = param2;
    }

    public function toString() : String {
      return "[ResourceFileInfo fileName=" + this.fileName + ", fileSize=" + this.fileSize + "]";
    }
  }
}
