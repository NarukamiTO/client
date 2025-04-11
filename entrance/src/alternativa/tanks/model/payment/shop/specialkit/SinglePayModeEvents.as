package alternativa.tanks.model.payment.shop.specialkit {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class SinglePayModeEvents implements SinglePayMode {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function SinglePayModeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPayMode() : IGameObject {
      var result:IGameObject = null;
      var i:int = 0;
      var m:SinglePayMode = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = SinglePayMode(this.impl[i]);
          result = m.getPayMode();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
