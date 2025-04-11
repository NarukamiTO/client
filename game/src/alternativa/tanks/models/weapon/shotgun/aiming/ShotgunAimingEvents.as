package alternativa.tanks.models.weapon.shotgun.aiming {
  import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
  import alternativa.tanks.models.weapon.shotgun.ShotgunRicochetTargetingSystem;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShotgunAimingEvents implements ShotgunAiming {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShotgunAimingEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createTargetingSystem() : ShotgunRicochetTargetingSystem {
      var result:ShotgunRicochetTargetingSystem = null;
      var i:int = 0;
      var m:ShotgunAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShotgunAiming(this.impl[i]);
          result = m.createTargetingSystem();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPelletDirectionCalculator() : PelletDirectionCalculator {
      var result:PelletDirectionCalculator = null;
      var i:int = 0;
      var m:ShotgunAiming = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShotgunAiming(this.impl[i]);
          result = m.getPelletDirectionCalculator();
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
