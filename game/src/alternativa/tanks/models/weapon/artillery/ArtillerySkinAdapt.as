package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtillerySkinAdapt implements ArtillerySkin {
    private var object:IGameObject;
    private var impl:ArtillerySkin;

    public function ArtillerySkinAdapt(param1:IGameObject, param2:ArtillerySkin) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkin() : ArtilleryTurretSkin {
      var result:ArtilleryTurretSkin = null;
      try {
        Model.object = this.object;
        result = this.impl.getSkin();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
