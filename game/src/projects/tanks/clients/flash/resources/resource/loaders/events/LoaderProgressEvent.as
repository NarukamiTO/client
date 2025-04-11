package projects.tanks.clients.flash.resources.resource.loaders.events {
  import flash.events.Event;
  import flash.events.ProgressEvent;

  public class LoaderProgressEvent extends ProgressEvent {
    public static const LOADER_PROGRESS:String = "loaderProgress";

    private var _partsTotal:int;
    private var _currentPart:int;
    private var _totalProgress:Number = 0;

    public function LoaderProgressEvent(param1:String, param2:int, param3:int, param4:Number = 0, param5:uint = 0, param6:uint = 0) {
      super(param1,false,false,param5,param6);
      this._partsTotal = param2;
      this._currentPart = param3;
      this._totalProgress = param4;
    }

    public function get partsTotal() : int {
      return this._partsTotal;
    }

    public function get currentPart() : int {
      return this._currentPart;
    }

    public function get totalProgress() : Number {
      return this._totalProgress;
    }

    override public function clone() : Event {
      return new LoaderProgressEvent(type,this._partsTotal,this._currentPart,this._totalProgress,bytesLoaded,bytesTotal);
    }

    override public function toString() : String {
      return "[LoaderProgressEvent partsTotal=" + this._partsTotal + ", currentPart=" + this._currentPart + ", totalProgress=" + this._totalProgress.toFixed(2) + "]";
    }
  }
}
