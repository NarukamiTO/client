package alternativa.tanks.model.item.discount {
  [ModelInterface]
  public interface IDiscount {
    function getDiscountInPercent() : int;
    function applyDiscount(param1:int) : int;
  }
}
