package alternativa.tanks.gui.shop.windows {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ShopCategoryEnum;

  public class ShopWindowParams {
    public var paymentObject:IGameObject;
    public var categoriesWithBonus:Vector.<IGameObject>;
    public var currentShopCategoryType:ShopCategoryEnum;
    public var shopCategories:Vector.<IGameObject>;
    public var shopItems:Vector.<IGameObject>;
    public var paymentModes:Vector.<IGameObject>;

    public function ShopWindowParams() {
      super();
    }
  }
}
