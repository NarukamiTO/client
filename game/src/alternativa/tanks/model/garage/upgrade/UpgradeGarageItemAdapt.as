package alternativa.tanks.model.garage.upgrade {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class UpgradeGarageItemAdapt implements UpgradeGarageItem {
    private var object:IGameObject;
    private var impl:UpgradeGarageItem;

    public function UpgradeGarageItemAdapt(param1:IGameObject, param2:UpgradeGarageItem) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isUpgradesEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isUpgradesEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
