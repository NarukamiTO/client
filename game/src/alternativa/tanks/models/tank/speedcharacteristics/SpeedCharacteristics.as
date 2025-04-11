package alternativa.tanks.models.tank.speedcharacteristics {
  [ModelInterface]
  public interface SpeedCharacteristics {
    function setInitialTankState() : void;
    function getMaxHullTurnSpeed() : Number;
    function getMaxTurretTurnSpeed() : Number;
    function getTurretRotationCoefficient() : Number;
  }
}
