package alternativa.tanks.model.item.upgradable {
  import projects.tanks.client.garage.models.item.videoads.IVideoAdsItemUpgradeModelBase;
  import projects.tanks.client.garage.models.item.videoads.VideoAdsItemUpgradeModelBase;

  [ModelInfo]
  public class VideoAdsItemUpgradeModel extends VideoAdsItemUpgradeModelBase implements IVideoAdsItemUpgradeModelBase {
    public function VideoAdsItemUpgradeModel() {
      super();
    }

    public function maxAdsShowed(param1:int) : void {
    }
  }
}
