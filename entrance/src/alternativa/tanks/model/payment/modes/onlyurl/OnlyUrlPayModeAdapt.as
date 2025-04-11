package alternativa.tanks.model.payment.modes.onlyurl {
  import platform.client.fp10.core.type.IGameObject;

  public class OnlyUrlPayModeAdapt implements OnlyUrlPayMode {
    private var object:IGameObject;
    private var impl:OnlyUrlPayMode;

    public function OnlyUrlPayModeAdapt(param1:IGameObject, param2:OnlyUrlPayMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
