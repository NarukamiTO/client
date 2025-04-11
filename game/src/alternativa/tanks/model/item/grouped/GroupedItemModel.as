package alternativa.tanks.model.item.grouped {
  import projects.tanks.client.garage.models.item.grouped.GroupedItemModelBase;
  import projects.tanks.client.garage.models.item.grouped.IGroupedItemModelBase;

  [ModelInfo]
  public class GroupedItemModel extends GroupedItemModelBase implements IGroupedItemModelBase, IGroupedItem {
    public function GroupedItemModel() {
      super();
    }

    public function isGrouped() : Boolean {
      return getInitParam().grouped;
    }

    public function getGroup() : int {
      return getInitParam().group;
    }
  }
}
