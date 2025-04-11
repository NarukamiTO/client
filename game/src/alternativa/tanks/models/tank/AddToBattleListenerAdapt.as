package alternativa.tanks.models.tank {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AddToBattleListenerAdapt implements AddToBattleListener {
    private var object:IGameObject;
    private var impl:AddToBattleListener;

    public function AddToBattleListenerAdapt(param1:IGameObject, param2:AddToBattleListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onAddToBattle() : void {
      try {
        Model.object = this.object;
        this.impl.onAddToBattle();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
