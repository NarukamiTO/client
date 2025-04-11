package alternativa.tanks.gui {
  import flash.events.Event;

  public class TabWindowsEvent extends Event {
    public static const ONCLICK:String = "TabWindowsEvent.ONCLICK";

    public function TabWindowsEvent(param1:String, param2:Boolean = false, param3:Boolean = false) {
      super(type,param2,param3);
    }
  }
}
