package alternativa.tanks.model.item.category {
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  [ModelInterface]
  public interface IItemCategory {
    function getCategory() : ItemCategoryEnum;
  }
}
