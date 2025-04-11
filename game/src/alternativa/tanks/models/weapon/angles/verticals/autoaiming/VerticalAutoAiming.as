package alternativa.tanks.models.weapon.angles.verticals.autoaiming {
  [ModelInterface]
  public interface VerticalAutoAiming {
    function getElevationAngleUp() : Number;
    function getNumRaysUp() : int;
    function getElevationAngleDown() : Number;
    function getNumRaysDown() : int;
    function getMaxAngle() : Number;
  }
}
