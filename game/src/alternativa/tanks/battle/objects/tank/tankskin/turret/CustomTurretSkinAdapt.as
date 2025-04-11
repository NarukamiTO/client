package alternativa.tanks.battle.objects.tank.tankskin.turret {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CustomTurretSkinAdapt implements CustomTurretSkin {
    private var object:IGameObject;
    private var impl:CustomTurretSkin;

    public function CustomTurretSkinAdapt(param1:IGameObject, param2:CustomTurretSkin) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createSkin(param1:Tanks3DSResource) : TurretSkin {
      var result:TurretSkin = null;
      var resource:Tanks3DSResource = param1;
      try {
        Model.object = this.object;
        result = this.impl.createSkin(resource);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
