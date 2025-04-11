package alternativa.tanks.models.weapon.shotgun.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShotgunSFXAdapt implements ShotgunSFX {
    private var object:IGameObject;
    private var impl:ShotgunSFX;

    public function ShotgunSFXAdapt(param1:IGameObject, param2:ShotgunSFX) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : ShotgunEffects {
      var result:ShotgunEffects = null;
      try {
        Model.object = this.object;
        result = this.impl.getEffects();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
