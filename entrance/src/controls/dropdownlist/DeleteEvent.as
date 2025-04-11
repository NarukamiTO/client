package controls.dropdownlist {
  import flash.events.Event;

  public class DeleteEvent extends Event {
    public static const REMOVED:String = "DeleteEvent.REMOVED";

    public var data:Object;

    public function DeleteEvent(param1:Object) {
      super(REMOVED,true);
      this.data = param1;
    }
  }
}
