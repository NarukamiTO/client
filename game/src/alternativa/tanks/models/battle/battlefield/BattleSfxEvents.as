package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BattleSfxEvents implements BattleSfx {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BattleSfxEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getLightingSfx() : LightingSfx {
      var result:LightingSfx = null;
      var i:int = 0;
      var m:BattleSfx = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BattleSfx(this.impl[i]);
          result = m.getLightingSfx();
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
