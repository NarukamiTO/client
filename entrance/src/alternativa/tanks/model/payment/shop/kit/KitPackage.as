package alternativa.tanks.model.payment.shop.kit {
  import projects.tanks.client.panel.model.shop.kitpackage.KitPackageItemInfo;

  [ModelInterface]
  public interface KitPackage {
    function getName() : String;
    function getItemInfos() : Vector.<KitPackageItemInfo>;
  }
}
