package projects.tanks.clients.flash.commons.models.detach {
  import projects.tanks.client.commons.models.detach.DetachModelBase;
  import projects.tanks.client.commons.models.detach.IDetachModelBase;

  [ModelInfo]
  public class DetachModel extends DetachModelBase implements IDetachModelBase, Detach {
    public function DetachModel() {
      super();
    }

    public function detach() : void {
      server.detach();
    }
  }
}
