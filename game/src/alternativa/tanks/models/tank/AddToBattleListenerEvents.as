package alternativa.tanks.models.tank {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class AddToBattleListenerEvents implements AddToBattleListener {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function AddToBattleListenerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onAddToBattle() : void {
      var i:int = 0;
      var m:AddToBattleListener = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = AddToBattleListener(this.impl[i]);
          m.onAddToBattle();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
