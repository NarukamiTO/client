package alternativa.tanks.model.item.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemViewCategoryEnum;

  public class IItemViewCategoryEvents implements IItemViewCategory {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IItemViewCategoryEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getViewCategory() : ItemViewCategoryEnum {
      var result:ItemViewCategoryEnum = null;
      var i:int = 0;
      var m:IItemViewCategory = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IItemViewCategory(this.impl[i]);
          result = m.getViewCategory();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
