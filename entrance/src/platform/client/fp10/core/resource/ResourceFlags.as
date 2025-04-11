package platform.client.fp10.core.resource {
  public class ResourceFlags {
    public static const LOADED:int = 1;
    public static const LOCAL:int = 1 << 1;
    public static const DUMMY_DATA:int = 1 << 2;
    public static const IS_LOADING:int = 1 << 3;

    public function ResourceFlags() {
      super();
    }
  }
}
