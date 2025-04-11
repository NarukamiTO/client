package alternativa.tanks.model.payment.modes {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PayModeDescriptionEvents implements PayModeDescription {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PayModeDescriptionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDescription() : String {
      var result:String = null;
      var i:int = 0;
      var m:PayModeDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeDescription(this.impl[i]);
          result = m.getDescription();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function rewriteCategoryDescription() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PayModeDescription = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PayModeDescription(this.impl[i]);
          result = Boolean(m.rewriteCategoryDescription());
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
