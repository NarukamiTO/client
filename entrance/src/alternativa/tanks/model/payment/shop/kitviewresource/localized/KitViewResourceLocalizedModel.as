package alternativa.tanks.model.payment.shop.kitviewresource.localized {
  import alternativa.tanks.model.payment.shop.kitviewresource.KitViewResource;
  import flash.display.BitmapData;
  import projects.tanks.client.panel.model.shop.kitview.localized.IKitViewResourceLocalizedModelBase;
  import projects.tanks.client.panel.model.shop.kitview.localized.KitViewResourceLocalizedModelBase;

  [ModelInfo]
  public class KitViewResourceLocalizedModel extends KitViewResourceLocalizedModelBase implements IKitViewResourceLocalizedModelBase, KitViewResource {
    public function KitViewResourceLocalizedModel() {
      super();
    }

    public function getButtonKitImage() : BitmapData {
      return getInitParam().buttonKit.data;
    }

    public function getButtonKitOverImage() : BitmapData {
      return getInitParam().buttonKitOver.data;
    }
  }
}
