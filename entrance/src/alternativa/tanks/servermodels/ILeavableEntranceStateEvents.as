package alternativa.tanks.servermodels {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ILeavableEntranceStateEvents implements ILeavableEntranceState {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ILeavableEntranceStateEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function leave() : void {
      var i:int = 0;
      var m:ILeavableEntranceState = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ILeavableEntranceState(this.impl[i]);
          m.leave();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
