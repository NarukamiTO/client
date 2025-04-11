package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.type.IGameObject;

  public class CrystalsOnlyPaymentModeAdapt implements CrystalsOnlyPaymentMode {
    private var object:IGameObject;
    private var impl:CrystalsOnlyPaymentMode;

    public function CrystalsOnlyPaymentModeAdapt(param1:IGameObject, param2:CrystalsOnlyPaymentMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }
  }
}
