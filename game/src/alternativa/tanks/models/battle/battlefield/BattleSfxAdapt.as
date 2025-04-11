package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleSfxAdapt implements BattleSfx {
    private var object:IGameObject;
    private var impl:BattleSfx;

    public function BattleSfxAdapt(param1:IGameObject, param2:BattleSfx) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getLightingSfx() : LightingSfx {
      var result:LightingSfx = null;
      try {
        Model.object = this.object;
        result = this.impl.getLightingSfx();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
