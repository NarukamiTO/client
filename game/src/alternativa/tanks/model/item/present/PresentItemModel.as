package alternativa.tanks.model.item.present {
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.present.IPresentItemModelBase;
  import projects.tanks.client.garage.models.item.present.PresentItemModelBase;

  [ModelInfo]
  public class PresentItemModel extends PresentItemModelBase implements IPresentItemModelBase, PresentImage {
    public function PresentItemModel() {
      super();
    }

    public function getImage() : ImageResource {
      return getInitParam().image;
    }
  }
}
