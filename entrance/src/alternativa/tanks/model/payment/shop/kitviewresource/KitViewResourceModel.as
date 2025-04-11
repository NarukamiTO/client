package alternativa.tanks.model.payment.shop.kitviewresource {
  import flash.display.BitmapData;
  import projects.tanks.client.panel.model.shop.kitview.IKitViewResourceModelBase;
  import projects.tanks.client.panel.model.shop.kitview.KitViewResourceModelBase;

  [ModelInfo]
  public class KitViewResourceModel extends KitViewResourceModelBase implements IKitViewResourceModelBase, KitViewResource {
    public function KitViewResourceModel() {
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
