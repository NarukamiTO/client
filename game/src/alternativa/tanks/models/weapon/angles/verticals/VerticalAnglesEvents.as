package alternativa.tanks.models.weapon.angles.verticals {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class VerticalAnglesEvents implements VerticalAngles {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function VerticalAnglesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getAngleUp() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:VerticalAngles = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAngles(this.impl[i]);
          result = Number(m.getAngleUp());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getAngleDown() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:VerticalAngles = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = VerticalAngles(this.impl[i]);
          result = Number(m.getAngleDown());
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
