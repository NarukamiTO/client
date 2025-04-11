package alternativa.tanks.model.payment.shop.lootbox {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LootBoxPackageEvents implements LootBoxPackage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function LootBoxPackageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:LootBoxPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = LootBoxPackage(this.impl[i]);
          result = int(m.getCount());
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
