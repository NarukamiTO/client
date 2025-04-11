package projects.tanks.clients.fp10.libraries.tanksservices.model.payment {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeProceedAdapt implements PayModeProceed {
    private var object:IGameObject;
    private var impl:PayModeProceed;

    public function PayModeProceedAdapt(param1:IGameObject, param2:PayModeProceed) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function proceedPayment() : void {
      try {
        Model.object = this.object;
        this.impl.proceedPayment();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
