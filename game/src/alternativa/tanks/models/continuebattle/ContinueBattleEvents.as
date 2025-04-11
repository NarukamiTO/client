package alternativa.tanks.models.continuebattle {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ContinueBattleEvents implements ContinueBattle {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ContinueBattleEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function continueBattle() : void {
      var i:int = 0;
      var m:ContinueBattle = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ContinueBattle(this.impl[i]);
          m.continueBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
