package alternativa.tanks.models.sfx.lighting {
  import alternativa.tanks.sfx.LightAnimation;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingEffectEntity;
  import projects.tanks.client.battlefield.models.tankparts.sfx.lighting.entity.LightingSFXEntity;

  public class LightingSfx {
    private var entity:LightingSFXEntity = null;

    public function LightingSfx(param1:LightingSFXEntity) {
      super();
      this.entity = param1;
    }

    public function createAnimation(param1:String) : LightAnimation {
      var local2:LightingEffectEntity = null;
      for each(local2 in this.entity.effects) {
        if(local2.effectName == param1) {
          return new LightAnimation(local2.items);
        }
      }
      return null;
    }
  }
}
