package alternativa.tanks.model.payment.shop.specialkit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SinglePayModeAdapt implements SinglePayMode {
    private var object:IGameObject;
    private var impl:SinglePayMode;

    public function SinglePayModeAdapt(param1:IGameObject, param2:SinglePayMode) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPayMode() : IGameObject {
      var result:IGameObject = null;
      try {
        Model.object = this.object;
        result = this.impl.getPayMode();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
