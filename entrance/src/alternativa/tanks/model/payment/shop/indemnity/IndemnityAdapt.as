package alternativa.tanks.model.payment.shop.indemnity {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IndemnityAdapt implements Indemnity {
    private var object:IGameObject;
    private var impl:Indemnity;

    public function IndemnityAdapt(param1:IGameObject, param2:Indemnity) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getIndemnitySize() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getIndemnitySize());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
