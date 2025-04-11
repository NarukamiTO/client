package alternativa.tanks.model.garage.passtoshop {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PassToShopServiceEvents implements PassToShopService {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PassToShopServiceEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isPassToShopEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:PassToShopService = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PassToShopService(this.impl[i]);
          result = Boolean(m.isPassToShopEnabled());
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
