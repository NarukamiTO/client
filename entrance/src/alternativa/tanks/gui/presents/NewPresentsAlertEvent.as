package alternativa.tanks.gui.presents {
  import flash.events.Event;

  public class NewPresentsAlertEvent extends Event {
    public static const ACCEPT:String = "NewPresentsAlertEvent.Accept";
    public static const CANCEL:String = "NewPresentsAlertEvent.Cancel";

    public function NewPresentsAlertEvent(param1:String) {
      super(param1);
    }
  }
}
