package alternativa.tanks.model.item.container.gui.opening {
  import flash.events.Event;

  public class ContainerEvent extends Event {
    public static var OPEN:String = "ContainerEvent_OPEN";

    public var count:int = 0;

    public function ContainerEvent(param1:int) {
      this.count = param1;
      super(OPEN,false,false);
    }
  }
}
