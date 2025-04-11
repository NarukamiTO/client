package alternativa.tanks.models.weapon.terminator {
  import alternativa.tanks.battle.objects.tank.tankskin.terminator.TerminatorTurretSkin;

  [ModelInterface]
  public interface TerminatorSkin {
    function getSkin() : TerminatorTurretSkin;
  }
}
