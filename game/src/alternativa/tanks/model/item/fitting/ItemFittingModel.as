package alternativa.tanks.model.item.fitting {
  import projects.tanks.client.garage.models.item.fitting.IItemFittingModelBase;
  import projects.tanks.client.garage.models.item.fitting.ItemFittingModelBase;

  [ModelInfo]
  public class ItemFittingModel extends ItemFittingModelBase implements IItemFittingModelBase, ItemFitting {
    public function ItemFittingModel() {
      super();
    }

    public function fit() : void {
      server.fit();
    }
  }
}
