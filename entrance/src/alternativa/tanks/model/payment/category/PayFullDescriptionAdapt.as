package alternativa.tanks.model.payment.category {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayFullDescriptionAdapt implements PayFullDescription {
    private var object:IGameObject;
    private var impl:PayFullDescription;

    public function PayFullDescriptionAdapt(param1:IGameObject, param2:PayFullDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getFullDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getFullDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
