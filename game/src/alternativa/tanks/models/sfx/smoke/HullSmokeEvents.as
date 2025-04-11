package alternativa.tanks.models.sfx.smoke {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class HullSmokeEvents implements HullSmoke {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function HullSmokeEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function controlChanged(param1:IGameObject, param2:int) : void {
      var i:int = 0;
      var m:HullSmoke = null;
      var user:IGameObject = param1;
      var controlState:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = HullSmoke(this.impl[i]);
          m.controlChanged(user,controlState);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
