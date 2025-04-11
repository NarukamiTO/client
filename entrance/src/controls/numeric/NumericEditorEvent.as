package controls.numeric {
  import flash.events.Event;

  public class NumericEditorEvent extends Event {
    public static const CHANGE:String = "numericEditorEvent.changed";

    private var changeByUser:Boolean;
    private var valid:Boolean;

    public function NumericEditorEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false) {
      super(param1,param4,param5);
      this.changeByUser = param3;
      this.valid = param2;
    }

    public function isChangedByUser() : Boolean {
      return this.changeByUser;
    }

    public function isValid() : Boolean {
      return this.valid;
    }
  }
}
