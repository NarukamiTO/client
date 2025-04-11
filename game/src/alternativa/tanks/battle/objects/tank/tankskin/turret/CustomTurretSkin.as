package alternativa.tanks.battle.objects.tank.tankskin.turret {
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  [ModelInterface]
  public interface CustomTurretSkin {
    function createSkin(param1:Tanks3DSResource) : TurretSkin;
  }
}
