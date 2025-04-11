package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.type.IGameObject;

  public class CrystalsOnlyPaymentModeEvents implements CrystalsOnlyPaymentMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function CrystalsOnlyPaymentModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
