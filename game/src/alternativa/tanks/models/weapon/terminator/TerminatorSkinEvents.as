package alternativa.tanks.models.weapon.terminator {
  import alternativa.tanks.battle.objects.tank.tankskin.terminator.TerminatorTurretSkin;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TerminatorSkinEvents implements TerminatorSkin {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TerminatorSkinEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkin() : TerminatorTurretSkin {
      var result:TerminatorTurretSkin = null;
      var i:int = 0;
      var m:TerminatorSkin = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TerminatorSkin(this.impl[i]);
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
