package alternativa.tanks.model.item.buyable {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBuyableAdapt implements IBuyable {
    private var object:IGameObject;
    private var impl:IBuyable;

    public function IBuyableAdapt(param1:IGameObject, param2:IBuyable) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPriceWithoutDiscount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPriceWithoutDiscount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPrice() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPrice());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isBuyable() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isBuyable());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
