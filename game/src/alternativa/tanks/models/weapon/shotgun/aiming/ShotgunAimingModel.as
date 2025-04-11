package alternativa.tanks.models.weapon.shotgun.aiming {
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.shotgun.PelletDirectionCalculator;
  import alternativa.tanks.models.weapon.shotgun.ShotgunRicochetTargetingSystem;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.IShotgunHittingModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.shotgun.ShotgunHittingModelBase;

  [ModelInfo]
  public class ShotgunAimingModel extends ShotgunHittingModelBase implements IShotgunHittingModelBase, ShotgunAiming {
    public function ShotgunAimingModel() {
      super();
    }

    public function createTargetingSystem() : ShotgunRicochetTargetingSystem {
      var local1:WeaponObject = new WeaponObject(object);
      return new ShotgunRicochetTargetingSystem(local1,this.getPelletDirectionCalculator(),getInitParam());
    }

    public function getPelletDirectionCalculator() : PelletDirectionCalculator {
      var local1:PelletDirectionCalculator = PelletDirectionCalculator(getData(PelletDirectionCalculator));
      if(local1 == null) {
        local1 = new PelletDirectionCalculator(getInitParam());
        putData(PelletDirectionCalculator,local1);
      }
      return local1;
    }
  }
}
