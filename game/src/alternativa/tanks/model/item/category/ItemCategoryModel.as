package alternativa.tanks.model.item.category {
  import projects.tanks.client.commons.types.ItemCategoryEnum;
  import projects.tanks.client.garage.models.item.category.IItemCategoryModelBase;
  import projects.tanks.client.garage.models.item.category.ItemCategoryModelBase;

  [ModelInfo]
  public class ItemCategoryModel extends ItemCategoryModelBase implements IItemCategoryModelBase, IItemCategory {
    public function ItemCategoryModel() {
      super();
    }

    public function getCategory() : ItemCategoryEnum {
      return getInitParam().category;
    }

    public function setCategory(param1:ItemCategoryEnum) : void {
      getInitParam().category = param1;
    }
  }
}
