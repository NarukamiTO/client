package alternativa.tanks.servermodels.serverhalt {
  import alternativa.tanks.service.IEntranceClientFacade;
  import platform.client.fp10.core.model.IObjectLoadListener;
  import projects.tanks.client.entrance.model.entrance.clienthalt.IServerHaltEntranceModelBase;
  import projects.tanks.client.entrance.model.entrance.clienthalt.ServerHaltEntranceModelBase;

  [ModelInfo]
  public class ServerHaltEntranceModel extends ServerHaltEntranceModelBase implements IServerHaltEntranceModelBase, IObjectLoadListener {
    [Inject]
    public static var facade:IEntranceClientFacade;

    public function ServerHaltEntranceModel() {
      super();
    }

    public function serverHalt() : void {
      facade.serverHalt();
    }

    public function objectLoaded() : void {
      if(getInitParam().serverHalt) {
        facade.serverHalt();
      }
    }

    public function objectLoadedPost() : void {
    }

    public function objectUnloaded() : void {
    }

    public function objectUnloadedPost() : void {
    }
  }
}
