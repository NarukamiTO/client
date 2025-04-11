package swfaddress {
  import flash.events.Event;

  public class SWFAddressEvent extends Event {
    public static const INIT:String = "init";
    public static const CHANGE:String = "change";

    private var _value:String;
    private var _path:String;
    private var _pathNames:Array;
    private var _parameters:Object;
    private var _parametersNames:Array;

    public function SWFAddressEvent(param1:String) {
      super(param1,false,false);
    }

    override public function get currentTarget() : Object {
      return SWFAddress;
    }

    override public function get type() : String {
      return super.type;
    }

    override public function get target() : Object {
      return SWFAddress;
    }

    public function get value() : String {
      if(this._value == null) {
        this._value = SWFAddress.getValue();
      }
      return this._value;
    }

    public function get path() : String {
      if(this._path == null) {
        this._path = SWFAddress.getPath();
      }
      return this._path;
    }

    public function get pathNames() : Array {
      if(this._pathNames == null) {
        this._pathNames = SWFAddress.getPathNames();
      }
      return this._pathNames;
    }

    public function get parameters() : Object {
      var local1:int = 0;
      if(this._parameters == null) {
        this._parameters = new Object();
        local1 = 0;
        while(local1 < this.parametersNames.length) {
          this._parameters[this.parametersNames[local1]] = SWFAddress.getParameter(this.parametersNames[local1]);
          local1++;
        }
      }
      return this._parameters;
    }

    public function get parametersNames() : Array {
      if(this._parametersNames == null) {
        this._parametersNames = SWFAddress.getParameterNames();
      }
      return this._parametersNames;
    }

    override public function clone() : Event {
      return new SWFAddressEvent(this.type);
    }

    override public function toString() : String {
      return formatToString("SWFAddressEvent","type","bubbles","cancelable","eventPhase","value","path","pathNames","parameters","parametersNames");
    }
  }
}
