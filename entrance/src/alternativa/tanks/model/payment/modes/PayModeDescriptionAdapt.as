package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeDescriptionAdapt implements PayModeDescription {
    private var object:IGameObject;
    private var impl:PayModeDescription;

    public function PayModeDescriptionAdapt(param1:IGameObject, param2:PayModeDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function rewriteCategoryDescription() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.rewriteCategoryDescription());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
