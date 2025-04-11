package alternativa.tanks.models.tank.bosstate {
  import projects.tanks.client.battlefield.models.user.bossstate.BossRelationRole;

  [ModelInterface]
  public interface IBossState {
    function role() : BossRelationRole;
  }
}
