package platform.client.fp10.core.network.connection {
  import platform.client.fp10.core.network.ICommandSender;
  import platform.client.fp10.core.service.transport.ITransportService;

  public class ControlConnectionSender implements ICommandSender {
    [Inject]
    public static var transportService:ITransportService;

    public function ControlConnectionSender() {
      super();
    }

    public function sendCommand(param1:Object) : void {
      var local2:ICommandSender = null;
      if(transportService == null || (local2 = transportService.controlConnection) == null) {
        return;
      }
      local2.sendCommand(param1);
    }
  }
}
