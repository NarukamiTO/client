package alternativa.tanks.model.payment.shop.cashpackage {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class CashPackageAdapt implements CashPackage {
    private var object:IGameObject;
    private var impl:CashPackage;

    public function CashPackageAdapt(param1:IGameObject, param2:CashPackage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAmount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getAmount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getBonusAmount() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getBonusAmount());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
