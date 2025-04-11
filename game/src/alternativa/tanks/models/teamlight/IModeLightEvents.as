package alternativa.tanks.models.teamlight {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IModeLightEvents implements IModeLight {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IModeLightEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getControlPointsMode() : ModeLight {
      var result:ModeLight = null;
      var i:int = 0;
      var m:IModeLight = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IModeLight(this.impl[i]);
          result = m.getControlPointsMode();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getCaptureFlagMode() : ModeLight {
      var result:ModeLight = null;
      var i:int = 0;
      var m:IModeLight = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IModeLight(this.impl[i]);
          result = m.getCaptureFlagMode();
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
