package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.models.weapon.artillery.sfx.ArtilleryEffects;

  [ModelInterface]
  public interface ArtilleryEffectsProvider {
    function getArtilleryEffects() : ArtilleryEffects;
  }
}
