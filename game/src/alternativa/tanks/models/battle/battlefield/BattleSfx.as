package alternativa.tanks.models.battle.battlefield {
  import alternativa.tanks.models.sfx.lighting.LightingSfx;

  [ModelInterface]
  public interface BattleSfx {
    function getLightingSfx() : LightingSfx;
  }
}
