package alternativa.tanks.model.payment.modes.description {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeBottomDescriptionInternalEvents implements PayModeBottomDescriptionInternal {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeBottomDescriptionInternalEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function setEnabled(param1:Boolean) : void {
      var i:int = 0;
      var m:PayModeBottomDescriptionInternal = null;
      var enabled:Boolean = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeBottomDescriptionInternal(this.impl[i]);
          m.setEnabled(enabled);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
