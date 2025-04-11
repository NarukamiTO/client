package alternativa.tanks.models.tank {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class RemoveFromBattleListenerEvents implements RemoveFromBattleListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function RemoveFromBattleListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onRemoveFromBattle() : void {
      var i:int = 0;
      var m:RemoveFromBattleListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = RemoveFromBattleListener(this.impl[i]);
          m.onRemoveFromBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
