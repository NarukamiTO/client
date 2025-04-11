package alternativa.tanks.model.payment.modes.onlyurl {
  import platform.client.fp10.core.type.IGameObject;

  public class OnlyUrlPayModeEvents implements OnlyUrlPayMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function OnlyUrlPayModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
