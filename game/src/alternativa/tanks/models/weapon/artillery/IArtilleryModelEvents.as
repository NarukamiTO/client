package alternativa.tanks.models.weapon.artillery {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IArtilleryModelEvents implements IArtilleryModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IArtilleryModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDefaultElevation() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:IArtilleryModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IArtilleryModel(this.impl[i]);
          result = Number(m.getDefaultElevation());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getWeapon() : ArtilleryWeapon {
      var result:ArtilleryWeapon = null;
      var i:int = 0;
      var m:IArtilleryModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IArtilleryModel(this.impl[i]);
          result = m.getWeapon();
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
