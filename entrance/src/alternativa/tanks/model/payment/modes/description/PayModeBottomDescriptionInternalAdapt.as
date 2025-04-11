package alternativa.tanks.model.payment.modes.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeBottomDescriptionInternalAdapt implements PayModeBottomDescriptionInternal {
    private var object:IGameObject;
    private var impl:PayModeBottomDescriptionInternal;

    public function PayModeBottomDescriptionInternalAdapt(param1:IGameObject, param2:PayModeBottomDescriptionInternal) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setEnabled(param1:Boolean) : void {
      var enabled:Boolean = param1;
      try {
        Model.object = this.object;
        this.impl.setEnabled(enabled);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
