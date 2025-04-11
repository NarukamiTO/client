package alternativa.tanks.model.garage.upgrade {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FlushUpgradesEvents implements FlushUpgrades {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function FlushUpgradesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function flushToServer(param1:DelayUpgrades, param2:IGameObject) : void {
      var i:int = 0;
      var m:FlushUpgrades = null;
      var delayUpgrades:DelayUpgrades = param1;
      var item:IGameObject = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FlushUpgrades(this.impl[i]);
          m.flushToServer(delayUpgrades,item);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
