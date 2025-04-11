package projects.tanks.clients.flash.resources.resource.loaders.events {
  import flash.events.ErrorEvent;
  import flash.events.Event;

  public class BatchTextureLoaderErrorEvent extends ErrorEvent {
    public static const LOADER_ERROR:String = "loaderError";

    private var _textureName:String;

    public function BatchTextureLoaderErrorEvent(param1:String, param2:String, param3:String) {
      super(param1);
      this.text = param3;
      this._textureName = param2;
    }

    public function get textureName() : String {
      return this._textureName;
    }

    override public function clone() : Event {
      return new BatchTextureLoaderErrorEvent(type,this._textureName,text);
    }

    override public function toString() : String {
      return "[BatchTextureLoaderErrorEvent textureName=" + this._textureName + ", text=" + text + "]";
    }
  }
}
