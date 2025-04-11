package alternativa.tanks.model.bonus.showing.info {
  import platform.client.fp10.core.resource.types.LocalizedImageResource;
  import projects.tanks.client.panel.model.bonus.showing.info.BonusInfoModelBase;
  import projects.tanks.client.panel.model.bonus.showing.info.IBonusInfoModelBase;

  [ModelInfo]
  public class BonusInfoModel extends BonusInfoModelBase implements IBonusInfoModelBase, BonusInfo {
    public function BonusInfoModel() {
      super();
    }

    public function getTopText() : String {
      return getInitParam().topText;
    }

    public function getBottomText() : String {
      return getInitParam().bottomText;
    }

    public function getImage() : LocalizedImageResource {
      return getInitParam().image;
    }
  }
}
