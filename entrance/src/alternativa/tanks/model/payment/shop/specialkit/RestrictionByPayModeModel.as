package alternativa.tanks.model.payment.shop.specialkit {
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.panel.model.shop.enable.paymode.IRestrictionByPayModeModelBase;
  import projects.tanks.client.panel.model.shop.enable.paymode.RestrictionByPayModeModelBase;

  [ModelInfo]
  public class RestrictionByPayModeModel extends RestrictionByPayModeModelBase implements IRestrictionByPayModeModelBase, SinglePayMode {
    public function RestrictionByPayModeModel() {
      super();
    }

    public function getPayMode() : IGameObject {
      return getInitParam().payMode;
    }
  }
}
