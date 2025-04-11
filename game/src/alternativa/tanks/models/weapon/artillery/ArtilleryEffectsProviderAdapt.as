package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtilleryEffectsProviderAdapt implements ArtilleryEffectsProvider {
    private var object:IGameObject;
    private var impl:ArtilleryEffectsProvider;

    public function ArtilleryEffectsProviderAdapt(param1:IGameObject, param2:ArtilleryEffectsProvider) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getArtilleryEffects() : ArtilleryEffects {
      var result:ArtilleryEffects = null;
      try {
        Model.object = this.object;
        result = this.impl.getArtilleryEffects();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
