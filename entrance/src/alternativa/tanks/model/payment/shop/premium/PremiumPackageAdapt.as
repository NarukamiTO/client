package alternativa.tanks.model.payment.shop.premium {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PremiumPackageAdapt implements PremiumPackage {
    private var object:IGameObject;
    private var impl:PremiumPackage;

    public function PremiumPackageAdapt(param1:IGameObject, param2:PremiumPackage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDurationInDays() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getDurationInDays());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
