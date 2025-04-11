package alternativa.tanks.model.garage.present {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentPurchaseEvents implements PresentPurchase {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PresentPurchaseEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function preparePresent(param1:IGameObject) : void {
      var i:int = 0;
      var m:PresentPurchase = null;
      var presentItem:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PresentPurchase(this.impl[i]);
          m.preparePresent(presentItem);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function confirmPresentPurchase(param1:IGameObject) : void {
      var i:int = 0;
      var m:PresentPurchase = null;
      var presentItem:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PresentPurchase(this.impl[i]);
          m.confirmPresentPurchase(presentItem);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
