package alternativa.tanks.model.garage.present {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PresentPurchaseAdapt implements PresentPurchase {
    private var object:IGameObject;
    private var impl:PresentPurchase;

    public function PresentPurchaseAdapt(param1:IGameObject, param2:PresentPurchase) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function preparePresent(param1:IGameObject) : void {
      var presentItem:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.preparePresent(presentItem);
      }
      finally {
        Model.popObject();
      }
    }

    public function confirmPresentPurchase(param1:IGameObject) : void {
      var presentItem:IGameObject = param1;
      try {
        Model.object = this.object;
        this.impl.confirmPresentPurchase(presentItem);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
