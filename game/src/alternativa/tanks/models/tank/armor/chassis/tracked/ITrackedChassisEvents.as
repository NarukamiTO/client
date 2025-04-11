package alternativa.tanks.models.tank.armor.chassis.tracked {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITrackedChassisEvents implements ITrackedChassis {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITrackedChassisEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDamping() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:ITrackedChassis = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITrackedChassis(this.impl[i]);
          result = Number(m.getDamping());
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
