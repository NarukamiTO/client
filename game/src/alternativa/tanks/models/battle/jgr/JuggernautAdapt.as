package alternativa.tanks.models.battle.jgr {
  import alternativa.types.Long;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class JuggernautAdapt implements Juggernaut {
    private var object:IGameObject;
    private var impl:Juggernaut;

    public function JuggernautAdapt(param1:IGameObject, param2:Juggernaut) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function bossId() : Long {
      var result:Long = null;
      try {
        Model.object = this.object;
        result = this.impl.bossId();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
