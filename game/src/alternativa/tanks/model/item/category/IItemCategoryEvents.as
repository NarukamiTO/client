package alternativa.tanks.model.item.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  public class IItemCategoryEvents implements IItemCategory {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IItemCategoryEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCategory() : ItemCategoryEnum {
      var result:ItemCategoryEnum = null;
      var i:int = 0;
      var m:IItemCategory = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IItemCategory(this.impl[i]);
          result = m.getCategory();
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
