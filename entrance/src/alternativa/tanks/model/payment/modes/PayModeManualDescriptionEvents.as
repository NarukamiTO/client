package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeManualDescriptionEvents implements PayModeManualDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeManualDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function hasCustomManualDescription() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PayModeManualDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeManualDescription(this.impl[i]);
          result = Boolean(m.hasCustomManualDescription());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCustomManualDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayModeManualDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeManualDescription(this.impl[i]);
          result = m.getCustomManualDescription();
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
