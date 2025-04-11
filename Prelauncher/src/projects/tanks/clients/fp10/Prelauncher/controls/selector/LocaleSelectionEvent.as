package projects.tanks.clients.fp10.Prelauncher.controls.selector {
  import flash.events.Event;
  import projects.tanks.clients.fp10.Prelauncher.Locale;

  public class LocaleSelectionEvent extends Event {
    public static const SELECTION:String = "selection";

    public var locale:Locale;

    public function LocaleSelectionEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type,bubbles,cancelable);
    }
  }
}
