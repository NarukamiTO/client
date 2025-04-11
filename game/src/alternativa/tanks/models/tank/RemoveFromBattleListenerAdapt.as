package alternativa.tanks.models.tank {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RemoveFromBattleListenerAdapt implements RemoveFromBattleListener {
    private var object:IGameObject;
    private var impl:RemoveFromBattleListener;

    public function RemoveFromBattleListenerAdapt(param1:IGameObject, param2:RemoveFromBattleListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onRemoveFromBattle() : void {
      try {
        Model.object = this.object;
        this.impl.onRemoveFromBattle();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
