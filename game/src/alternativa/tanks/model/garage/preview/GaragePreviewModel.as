package alternativa.tanks.model.garage.preview {
  import projects.tanks.client.garage.models.garagepreview.GaragePreviewModelBase;
  import projects.tanks.client.garage.models.garagepreview.IGaragePreviewModelBase;

  [ModelInfo]
  public class GaragePreviewModel extends GaragePreviewModelBase implements IGaragePreviewModelBase {
    public function GaragePreviewModel() {
      super();
    }

    public function setHasBatteries(param1:Boolean) : void {
    }
  }
}
