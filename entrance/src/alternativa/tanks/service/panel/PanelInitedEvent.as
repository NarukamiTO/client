package alternativa.tanks.service.panel {
  import flash.events.Event;

  public class PanelInitedEvent extends Event {
    public static const TYPE:String = "PanelInitedEvent";

    public function PanelInitedEvent() {
      super(TYPE);
    }
  }
}
