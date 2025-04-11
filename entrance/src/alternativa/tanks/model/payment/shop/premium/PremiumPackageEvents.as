package alternativa.tanks.model.payment.shop.premium {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class PremiumPackageEvents implements PremiumPackage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function PremiumPackageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDurationInDays() : int {
      var result:int = 0;
      var i:int = 0;
      var m:PremiumPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = PremiumPackage(this.impl[i]);
          result = int(m.getDurationInDays());
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
