package alternativa.tanks.models.tank.ultimate.mammoth {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ImpactEnableEvents implements ImpactEnable {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ImpactEnableEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isImpactEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ImpactEnable = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ImpactEnable(this.impl[i]);
          result = Boolean(m.isImpactEnabled());
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
