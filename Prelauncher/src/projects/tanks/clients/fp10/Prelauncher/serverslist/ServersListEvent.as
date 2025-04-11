package projects.tanks.clients.fp10.Prelauncher.serverslist {
  import flash.events.Event;

  public class ServersListEvent extends Event {
    public static const ERROR:String = "ServersListEvent.ERROR";
    public static const LOADED:String = "ServersListEvent.LOADED";

    public var serversList:Vector.<ServerNode>;

    public function ServersListEvent(type:String, serversList:Vector.<ServerNode> = null, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type,bubbles,cancelable);
      this.serversList = serversList;
    }
  }
}
