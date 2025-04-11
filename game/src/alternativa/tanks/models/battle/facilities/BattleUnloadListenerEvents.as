package alternativa.tanks.models.battle.facilities {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleUnloadListenerEvents implements BattleUnloadListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleUnloadListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function battleUnload() : void {
      var i:int = 0;
      var m:BattleUnloadListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleUnloadListener(this.impl[i]);
          m.battleUnload();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
