package alternativa.tanks.model.payment.shop.specialkit {
  import projects.tanks.client.panel.model.shop.specialkit.SpecialKitPackageCC;

  [ModelInterface]
  public interface SpecialKitPackage {
    function getCrystalsAmount() : int;
    function getPremiumDurationInDays() : int;
    function getEverySupplyAmount() : int;
    function getGoldAmount() : int;
    function hasAdditionalItem() : Boolean;
    function getItemsCount() : int;
    function getPackageData() : SpecialKitPackageCC;
  }
}
