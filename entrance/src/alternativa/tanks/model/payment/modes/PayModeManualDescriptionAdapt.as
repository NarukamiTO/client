package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeManualDescriptionAdapt implements PayModeManualDescription {
    private var object:IGameObject;
    private var impl:PayModeManualDescription;

    public function PayModeManualDescriptionAdapt(param1:IGameObject, param2:PayModeManualDescription) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function hasCustomManualDescription() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.hasCustomManualDescription());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCustomManualDescription() : String {
      var result:String = null;
      try {
        Model.object = this.object;
        result = this.impl.getCustomManualDescription();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
