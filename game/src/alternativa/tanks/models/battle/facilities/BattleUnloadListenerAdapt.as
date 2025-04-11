package alternativa.tanks.models.battle.facilities {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleUnloadListenerAdapt implements BattleUnloadListener {
    private var object:IGameObject;
    private var impl:BattleUnloadListener;

    public function BattleUnloadListenerAdapt(param1:IGameObject, param2:BattleUnloadListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function battleUnload() : void {
      try {
        Model.object = this.object;
        this.impl.battleUnload();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
