package alternativa.tanks.view.forms.freeuids {
  import flash.events.Event;

  public class FreeUidsFormEvent extends Event {
    public static const FOCUS_OUT:String = "FreeUidsFormEvent.FOCUS_OUT";
    public static const CLICK_ITEM:String = "FreeUidsFormEvent.CLICK_ITEM";

    private var _uid:String;

    public function FreeUidsFormEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(param1,param2,param3);
    }

    public function get uid() : String {
      return this._uid;
    }

    public function set uid(param1:String) : void {
      this._uid = param1;
    }
  }
}
