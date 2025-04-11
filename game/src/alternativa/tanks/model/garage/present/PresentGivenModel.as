package alternativa.tanks.model.garage.present {
  import alternativa.types.Long;
  import projects.tanks.client.garage.models.garage.present.IPresentGivenModelBase;
  import projects.tanks.client.garage.models.garage.present.PresentGivenModelBase;

  [ModelInfo]
  public class PresentGivenModel extends PresentGivenModelBase implements IPresentGivenModelBase, PresentGiven {
    public function PresentGivenModel() {
      super();
    }

    public function removePresent(param1:Long) : void {
      server.removePresent(param1);
    }
  }
}
