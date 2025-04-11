package alternativa.tanks.model.item.item {
  import platform.client.fp10.core.resource.types.ImageResource;
  import projects.tanks.client.garage.models.item.item.IItemModelBase;
  import projects.tanks.client.garage.models.item.item.ItemModelBase;

  [ModelInfo]
  public class ItemModel extends ItemModelBase implements IItemModelBase, IItem {
    public function ItemModel() {
      super();
    }

    public function getPosition() : int {
      return getInitParam().position;
    }

    public function getPreviewResource() : ImageResource {
      return getInitParam().preview;
    }

    public function getMaxRank() : int {
      return getInitParam().maxRank;
    }

    public function getMinRank() : int {
      return getInitParam().minRank;
    }
  }
}
