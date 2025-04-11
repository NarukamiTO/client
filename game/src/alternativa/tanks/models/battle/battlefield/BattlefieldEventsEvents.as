package alternativa.tanks.models.battle.battlefield {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattlefieldEventsEvents implements BattlefieldEvents {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattlefieldEventsEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onBattleLoaded() : void {
      var i:int = 0;
      var m:BattlefieldEvents = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattlefieldEvents(this.impl[i]);
          m.onBattleLoaded();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
