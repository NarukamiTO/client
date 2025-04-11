package alternativa.tanks.models.weapon.angles.verticals {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class VerticalAnglesAdapt implements VerticalAngles {
    private var object:IGameObject;
    private var impl:VerticalAngles;

    public function VerticalAnglesAdapt(param1:IGameObject, param2:VerticalAngles) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAngleUp() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getAngleUp());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getAngleDown() : Number {
      var result:Number = NaN;
      try {
        Model.object = this.object;
        result = Number(this.impl.getAngleDown());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
