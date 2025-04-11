package alternativa.engine3d.loaders.events {
  import flash.events.ErrorEvent;
  import flash.events.Event;

  public class LoaderErrorEvent extends ErrorEvent {
    public static const LOADER_ERROR:String = "loaderError";

    private var _url:String;

    public function LoaderErrorEvent(param1:String, param2:String, param3:String) {
      super(param1);
      this.text = param3;
      this._url = param2;
    }

    public function get url() : String {
      return this._url;
    }

    override public function clone() : Event {
      return new LoaderErrorEvent(type,this._url,text);
    }

    override public function toString() : String {
      return "[LoaderErrorEvent url=" + this._url + ", text=" + text + "]";
    }
  }
}
