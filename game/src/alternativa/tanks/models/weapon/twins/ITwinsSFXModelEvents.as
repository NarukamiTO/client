package alternativa.tanks.models.weapon.twins {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITwinsSFXModelEvents implements ITwinsSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITwinsSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getPlasmaWeaponEffects() : TwinsEffects {
      var result:TwinsEffects = null;
      var i:int = 0;
      var m:ITwinsSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITwinsSFXModel(this.impl[i]);
          result = m.getPlasmaWeaponEffects();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSFXData() : TwinsSFXData {
      var result:TwinsSFXData = null;
      var i:int = 0;
      var m:ITwinsSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITwinsSFXModel(this.impl[i]);
          result = m.getSFXData();
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
