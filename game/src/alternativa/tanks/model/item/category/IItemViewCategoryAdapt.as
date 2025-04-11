package alternativa.tanks.model.item.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class IItemViewCategoryAdapt implements IItemViewCategory {
    private var object:IGameObject;
    private var impl:IItemViewCategory;

    public function IItemViewCategoryAdapt(param1:IGameObject, param2:IItemViewCategory) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getViewCategory() : ItemViewCategoryEnum {
      var result:ItemViewCategoryEnum = null;
      try {
        Model.object = this.object;
        result = this.impl.getViewCategory();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
