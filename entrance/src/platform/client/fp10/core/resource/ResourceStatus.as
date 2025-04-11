package platform.client.fp10.core.resource {
  public class ResourceStatus {
    public static const QUEUED:String = "Queued";
    public static const REQUESTED:String = "Data requested";
    public static const LOADED:String = "Loaded";
    public static const LOAD_ERROR:String = "Loading error";
    public static const UNLOADED:String = "Unloaded";

    public function ResourceStatus() {
      super();
    }
  }
}
