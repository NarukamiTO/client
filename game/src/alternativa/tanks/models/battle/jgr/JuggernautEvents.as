package alternativa.tanks.models.battle.jgr {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class JuggernautEvents implements Juggernaut {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function JuggernautEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function bossId() : Long {
      var result:Long = null;
      var i:int = 0;
      var m:Juggernaut = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Juggernaut(this.impl[i]);
          result = m.bossId();
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
