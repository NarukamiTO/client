package alternativa.tanks.models.weapon.artillery {
  import alternativa.tanks.battle.objects.tank.tankskin.turret.ArtilleryTurretSkin;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArtillerySkinEvents implements ArtillerySkin {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ArtillerySkinEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkin() : ArtilleryTurretSkin {
      var result:ArtilleryTurretSkin = null;
      var i:int = 0;
      var m:ArtillerySkin = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ArtillerySkin(this.impl[i]);
          result = m.getSkin();
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
