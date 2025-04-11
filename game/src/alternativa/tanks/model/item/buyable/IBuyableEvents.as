package alternativa.tanks.model.item.buyable {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IBuyableEvents implements IBuyable {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IBuyableEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPriceWithoutDiscount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IBuyable = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBuyable(this.impl[i]);
          result = int(m.getPriceWithoutDiscount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPrice() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IBuyable = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBuyable(this.impl[i]);
          result = int(m.getPrice());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isBuyable() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IBuyable = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IBuyable(this.impl[i]);
          result = Boolean(m.isBuyable());
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
