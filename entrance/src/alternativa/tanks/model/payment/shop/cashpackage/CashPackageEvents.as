package alternativa.tanks.model.payment.shop.cashpackage {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class CashPackageEvents implements CashPackage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function CashPackageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAmount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:CashPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = CashPackage(this.impl[i]);
          result = int(m.getAmount());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getBonusAmount() : int {
      var result:int = 0;
      var i:int = 0;
      var m:CashPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = CashPackage(this.impl[i]);
          result = int(m.getBonusAmount());
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
