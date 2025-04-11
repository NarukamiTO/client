package alternativa.tanks.models.weapon.shaft {
  public interface ShaftAimingStateListener {
    function onAimingStart() : void;
    function onAimingStop() : void;
    function onAimedShot() : void;
  }
}
