package alternativa.tanks.model.payment.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayFullDescriptionEvents implements PayFullDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayFullDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getFullDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayFullDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayFullDescription(this.impl[i]);
          result = m.getFullDescription();
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
