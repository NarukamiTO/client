package alternativa.tanks.models.continuebattle {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ContinueBattleAdapt implements ContinueBattle {
    private var object:IGameObject;
    private var impl:ContinueBattle;

    public function ContinueBattleAdapt(param1:IGameObject, param2:ContinueBattle) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function continueBattle() : void {
      try {
        Model.object = this.object;
        this.impl.continueBattle();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
