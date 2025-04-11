package alternativa.tanks.sfx.drone {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class DroneSFXEvents implements DroneSFX {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function DroneSFXEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : DroneSFXData {
      var result:DroneSFXData = null;
      var i:int = 0;
      var m:DroneSFX = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = DroneSFX(this.impl[i]);
          result = m.getSfxData();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
