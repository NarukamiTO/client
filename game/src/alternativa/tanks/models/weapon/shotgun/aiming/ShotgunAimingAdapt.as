package alternativa.tanks.models.weapon.shotgun.aiming {
  import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
  import alternativa.tanks.models.weapon.shotgun.ShotgunRicochetTargetingSystem;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShotgunAimingAdapt implements ShotgunAiming {
    private var object:IGameObject;
    private var impl:ShotgunAiming;

    public function ShotgunAimingAdapt(param1:IGameObject, param2:ShotgunAiming) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createTargetingSystem() : ShotgunRicochetTargetingSystem {
      var result:ShotgunRicochetTargetingSystem = null;
      try {
        Model.object = this.object;
        result = this.impl.createTargetingSystem();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getPelletDirectionCalculator() : PelletDirectionCalculator {
      var result:PelletDirectionCalculator = null;
      try {
        Model.object = this.object;
        result = this.impl.getPelletDirectionCalculator();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
