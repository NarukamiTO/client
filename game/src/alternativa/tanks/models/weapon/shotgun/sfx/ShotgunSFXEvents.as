package alternativa.tanks.models.weapon.shotgun.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShotgunSFXEvents implements ShotgunSFX {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShotgunSFXEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getEffects() : ShotgunEffects {
      var result:ShotgunEffects = null;
      var i:int = 0;
      var m:ShotgunSFX = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShotgunSFX(this.impl[i]);
          result = m.getEffects();
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
