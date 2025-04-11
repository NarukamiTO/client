package alternativa.tanks.models.tank.armor.chassis.tracked {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITrackedChassisAdapt implements ITrackedChassis {
    private var object:IGameObject;
    private var impl:ITrackedChassis;

    public function ITrackedChassisAdapt(param1:IGameObject, param2:ITrackedChassis) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDamping() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getDamping());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
