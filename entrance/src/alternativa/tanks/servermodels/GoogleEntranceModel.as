package alternativa.tanks.servermodels {
  import projects.tanks.client.entrance.model.entrance.google.GoogleEntranceModelBase;
  import projects.tanks.client.entrance.model.entrance.google.IGoogleEntranceModelBase;

  [ModelInfo]
  public class GoogleEntranceModel extends GoogleEntranceModelBase implements IGoogleEntranceModelBase, IGoogleEntranceModel {
    public function GoogleEntranceModel() {
      super();
    }

    public function login(param1:String) : void {
      server.login(param1);
    }
  }
}
