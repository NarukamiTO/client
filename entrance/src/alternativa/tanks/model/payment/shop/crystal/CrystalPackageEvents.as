package alternativa.tanks.model.payment.shop.crystal {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class CrystalPackageEvents implements CrystalPackage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function CrystalPackageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPremiumDurationInDays() : int {
      var result:int = 0;
      var i:int = 0;
      var m:CrystalPackage = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = CrystalPackage(this.impl[i]);
          result = int(m.getPremiumDurationInDays());
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
