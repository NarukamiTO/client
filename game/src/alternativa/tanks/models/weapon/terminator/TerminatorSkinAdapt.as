package alternativa.tanks.models.weapon.terminator {
  import alternativa.tanks.battle.objects.tank.tankskin.terminator.TerminatorTurretSkin;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TerminatorSkinAdapt implements TerminatorSkin {
    private var object:IGameObject;
    private var impl:TerminatorSkin;

    public function TerminatorSkinAdapt(param1:IGameObject, param2:TerminatorSkin) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkin() : TerminatorTurretSkin {
      var result:TerminatorTurretSkin = null;
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
