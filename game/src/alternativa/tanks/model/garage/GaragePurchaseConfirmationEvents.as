package alternativa.tanks.model.garage {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GaragePurchaseConfirmationEvents implements GaragePurchaseConfirmation {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GaragePurchaseConfirmationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function showConfirmationAlert(param1:int) : void {
      var i:int = 0;
      var m:GaragePurchaseConfirmation = null;
      var cost:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaragePurchaseConfirmation(this.impl[i]);
          m.showConfirmationAlert(cost);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
