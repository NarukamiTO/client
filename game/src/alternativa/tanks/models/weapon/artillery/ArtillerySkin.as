package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;

  [ModelInterface]
  public interface ArtillerySkin {
    function getSkin() : ArtilleryTurretSkin;
  }
}
