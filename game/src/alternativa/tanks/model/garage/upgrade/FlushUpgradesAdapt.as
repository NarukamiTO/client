package alternativa.tanks.model.garage.upgrade {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FlushUpgradesAdapt implements FlushUpgrades {
    private var object:IGameObject;
    private var impl:FlushUpgrades;

    public function FlushUpgradesAdapt(param1:IGameObject, param2:FlushUpgrades) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function flushToServer(param1:DelayUpgrades, param2:IGameObject) : void {
      var delayUpgrades:DelayUpgrades = param1;
      var item:IGameObject = param2;
      try {
        Model.object = this.object;
        this.impl.flushToServer(delayUpgrades,item);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
