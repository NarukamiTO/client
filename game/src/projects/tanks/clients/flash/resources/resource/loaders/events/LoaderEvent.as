package projects.tanks.clients.flash.resources.resource.loaders.events {
  import flash.events.Event;

  public class LoaderEvent extends Event {
    public static const PART_OPEN:String = "partOpen";
    public static const PART_COMPLETE:String = "partComplete";

    private var _partsTotal:int;
    private var _currentPart:int;

    public function LoaderEvent(param1:String, param2:int, param3:int) {
      super(param1);
      this._partsTotal = param2;
      this._currentPart = param3;
    }

    public function get partsTotal() : int {
      return this._partsTotal;
    }

    public function get currentPart() : int {
      return this._currentPart;
    }

    override public function clone() : Event {
      return new LoaderEvent(type,this._partsTotal,this._currentPart);
    }

    override public function toString() : String {
      return "[LoaderEvent type=" + type + ", partsTotal=" + this._partsTotal + ", currentPart=" + this._currentPart + "]";
    }
  }
}
