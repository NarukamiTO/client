package projects.tanks.clients.fp10.libraries.tanksservices.model.payment {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeProceedEvents implements PayModeProceed {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeProceedEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function proceedPayment() : void {
      var i:int = 0;
      var m:PayModeProceed = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeProceed(this.impl[i]);
          m.proceedPayment();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
