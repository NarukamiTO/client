package alternativa.startup {
  import flash.display.Loader;

  public class LibraryInfo {
    public var name:String;
    public var url:String;
    public var activatorClassName:String;
    public var loader:Loader;
    public var loadingCallback:Function;

    public function LibraryInfo(param1:String, param2:String) {
      super();
      this.name = param1;
      this.url = param2;
    }
  }
}
