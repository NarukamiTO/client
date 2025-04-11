package projects.tanks.clients.flash.commons.models.serverhalt {
  import forms.ServerStopAlert;
  import projects.tanks.client.commons.models.clienthalt.IServerHaltModelBase;
  import projects.tanks.client.commons.models.clienthalt.ServerHaltModelBase;
  import projects.tanks.clients.flash.commons.services.serverhalt.IServerHaltService;

  [ModelInfo]
  public class ServerHaltModel extends ServerHaltModelBase implements IServerHaltModelBase {
    [Inject]
    public static var serverHaltService:IServerHaltService;

    public function ServerHaltModel() {
      super();
    }

    public function haltServer(param1:int) : void {
      serverHaltService.setServerHalt(true);
      var local2:ServerStopAlert = new ServerStopAlert(param1);
    }
  }
}
