package alternativa.tanks.battle.objects.tank.tankskin.turret {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CustomTurretSkinEvents implements CustomTurretSkin {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function CustomTurretSkinEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createSkin(param1:Tanks3DSResource) : TurretSkin {
      var result:TurretSkin = null;
      var i:int = 0;
      var m:CustomTurretSkin = null;
      var resource:Tanks3DSResource = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = CustomTurretSkin(this.impl[i]);
          result = m.createSkin(resource);
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
