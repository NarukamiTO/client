package alternativa.engine3d.loaders.events {
  import flash.events.Event;
  import flash.events.ProgressEvent;

  public class LoaderProgressEvent extends ProgressEvent {
    public static const LOADER_PROGRESS:String = "loaderProgress";

    private var _filesTotal:int;
    private var _filesLoaded:int;
    private var _totalProgress:Number = 0;

    public function LoaderProgressEvent(param1:String, param2:int, param3:int, param4:Number = 0, param5:uint = 0, param6:uint = 0) {
      super(param1,false,false,param5,param6);
      this._filesTotal = param2;
      this._filesLoaded = param3;
      this._totalProgress = param4;
    }

    public function get filesTotal() : int {
      return this._filesTotal;
    }

    public function get filesLoaded() : int {
      return this._filesLoaded;
    }

    public function get totalProgress() : Number {
      return this._totalProgress;
    }

    override public function clone() : Event {
      return new LoaderProgressEvent(type,this._filesTotal,this._filesLoaded,this._totalProgress,bytesLoaded,bytesTotal);
    }

    override public function toString() : String {
      return "[LoaderProgressEvent filesTotal=" + this._filesTotal + ", filesLoaded=" + this._filesLoaded + ", totalProgress=" + this._totalProgress.toFixed(2) + "]";
    }
  }
}
