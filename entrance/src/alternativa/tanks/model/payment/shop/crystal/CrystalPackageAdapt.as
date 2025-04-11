package alternativa.tanks.model.payment.shop.crystal {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class CrystalPackageAdapt implements CrystalPackage {
    private var object:IGameObject;
    private var impl:CrystalPackage;

    public function CrystalPackageAdapt(param1:IGameObject, param2:CrystalPackage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPremiumDurationInDays() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getPremiumDurationInDays());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
