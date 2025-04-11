package alternativa.tanks.models.weapon.angles.verticals.autoaiming {
  import alternativa.tanks.models.weapon.angles.verticals.VerticalAngles;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
  import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.IVerticalAutoAimingModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.angles.verticals.VerticalAutoAimingModelBase;

  [ModelInfo]
  public class VerticalAutoAimingModel extends VerticalAutoAimingModelBase implements IVerticalAutoAimingModelBase, VerticalAutoAiming {
    private static const MAXIMUM_RAYS_PER_RADIAN:Number = 8 * 180 / Math.PI;
    private static const MIN_TANK_SIZE:Number = 90;

    public function VerticalAutoAimingModel() {
      super();
    }

    private static function getNumRays(param1:Number) : int {
      var local2:Number = NaN;
      var local3:DistanceWeakening = null;
      if(object.hasModel(IWeaponWeakeningModel)) {
        local3 = IWeaponWeakeningModel(object.adapt(IWeaponWeakeningModel)).getDistanceWeakening();
        local2 = calculateRaysPerRadian(local3.getFullDamageDistance());
      } else {
        local2 = MAXIMUM_RAYS_PER_RADIAN;
      }
      return Math.ceil(param1 * local2);
    }

    public static function calculateRaysPerRadian(param1:Number) : Number {
      return Math.min(MAXIMUM_RAYS_PER_RADIAN,1 / (2 * Math.atan(MIN_TANK_SIZE / (2 * param1))));
    }

    public function getElevationAngleUp() : Number {
      return this.verticalAngles().getAngleUp();
    }

    public function getNumRaysUp() : int {
      return getNumRays(this.getElevationAngleUp());
    }

    public function getElevationAngleDown() : Number {
      return this.verticalAngles().getAngleDown();
    }

    public function getNumRaysDown() : int {
      return getNumRays(this.getElevationAngleDown());
    }

    public function getMaxAngle() : Number {
      return Math.max(this.getElevationAngleDown(),this.getElevationAngleUp());
    }

    private function verticalAngles() : VerticalAngles {
      return VerticalAngles(object.adapt(VerticalAngles));
    }
  }
}
