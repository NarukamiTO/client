package alternativa.tanks.model.garage.upgrade {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UpgradeGarageItemEvents implements UpgradeGarageItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function UpgradeGarageItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isUpgradesEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:UpgradeGarageItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = UpgradeGarageItem(this.impl[i]);
          result = Boolean(m.isUpgradesEnabled());
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
