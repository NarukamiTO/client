package alternativa.tanks.model.payment.shop.lootbox {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class LootBoxPackageAdapt implements LootBoxPackage {
    private var object:IGameObject;
    private var impl:LootBoxPackage;

    public function LootBoxPackageAdapt(param1:IGameObject, param2:LootBoxPackage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getCount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
