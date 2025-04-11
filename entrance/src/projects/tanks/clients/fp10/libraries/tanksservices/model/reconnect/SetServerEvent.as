package projects.tanks.clients.fp10.libraries.tanksservices.model.reconnect {
  import flash.events.Event;

  public class SetServerEvent extends Event {
    public var serverNumber:int = 0;

    public function SetServerEvent(param1:String, param2:int) {
      super(param1,false,false);
      this.serverNumber = param2;
    }
  }
}
