package alternativa.tanks.model.item.buyable {
  [ModelInterface]
  public interface IBuyable {
    function getPriceWithoutDiscount() : int;
    function getPrice() : int;
    function isBuyable() : Boolean;
  }
}
