package alternativa.tanks.model.item.category {
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  [ModelInterface]
  public interface IItemViewCategory {
    function getViewCategory() : ItemViewCategoryEnum;
  }
}
