package alternativa.tanks.model.payment.shop.goldbox {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GoldBoxPackageAdapt implements GoldBoxPackage {
    private var object:IGameObject;
    private var impl:GoldBoxPackage;

    public function GoldBoxPackageAdapt(param1:IGameObject, param2:GoldBoxPackage) {
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
