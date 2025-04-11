package alternativa.tanks.model.garage {
  import platform.client.fp10.core.resource.types.ImageResource;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemCategoryEnum;

  public class BuyableItemInfo {
    public var item:IGameObject;
    public var category:ItemCategoryEnum;
    public var preview:ImageResource;
    public var cost:int;
    public var isCountable:Boolean;
    public var modificationIndex:int;

    public function BuyableItemInfo(param1:IGameObject, param2:ItemCategoryEnum, param3:ImageResource, param4:int, param5:Boolean = false, param6:int = -1) {
      super();
      this.item = param1;
      this.category = param2;
      this.preview = param3;
      this.cost = param4;
      this.isCountable = param5;
      this.modificationIndex = param6;
    }
  }
}
