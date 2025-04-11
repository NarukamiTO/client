package alternativa.tanks.models.effects.activeafetrdeath {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IActiveAfterDeathEvents implements IActiveAfterDeath {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IActiveAfterDeathEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IActiveAfterDeath = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IActiveAfterDeath(this.impl[i]);
          result = Boolean(m.isEnabled());
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
