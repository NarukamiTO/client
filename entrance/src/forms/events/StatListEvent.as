package forms.events {
  import flash.events.Event;

  public class StatListEvent extends Event {
    public static const UPDATE_SORT:String = "StatListUpdateSort";

    public var sortField:int;

    public function StatListEvent(param1:int) {
      this.sortField = param1;
      super(UPDATE_SORT,true);
    }
  }
}
