package alternativa.tanks.model.payment.shop.featuring {
  [ModelInterface]
  public interface ShopItemFeaturing {
    function isLocatedInFeaturingCategory() : Boolean;
    function isHiddenInOriginalCategory() : Boolean;
    function getPosition() : int;
  }
}
