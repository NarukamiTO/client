package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtilleryEffectsProviderEvents implements ArtilleryEffectsProvider {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ArtilleryEffectsProviderEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getArtilleryEffects() : ArtilleryEffects {
      var result:ArtilleryEffects = null;
      var i:int = 0;
      var m:ArtilleryEffectsProvider = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ArtilleryEffectsProvider(this.impl[i]);
          result = m.getArtilleryEffects();
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
