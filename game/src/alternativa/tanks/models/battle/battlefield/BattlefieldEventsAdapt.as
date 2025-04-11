package alternativa.tanks.models.battle.battlefield {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattlefieldEventsAdapt implements BattlefieldEvents {
    private var object:IGameObject;
    private var impl:BattlefieldEvents;

    public function BattlefieldEventsAdapt(param1:IGameObject, param2:BattlefieldEvents) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onBattleLoaded() : void {
      try {
        Model.object = this.object;
        this.impl.onBattleLoaded();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
