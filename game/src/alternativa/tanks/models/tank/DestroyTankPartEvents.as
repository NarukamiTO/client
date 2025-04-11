package alternativa.tanks.models.tank {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DestroyTankPartEvents implements DestroyTankPart {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DestroyTankPartEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function destroyTankPart() : void {
      var i:int = 0;
      var m:DestroyTankPart = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DestroyTankPart(this.impl[i]);
          m.destroyTankPart();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
