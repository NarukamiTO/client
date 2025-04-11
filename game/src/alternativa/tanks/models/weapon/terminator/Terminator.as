package alternativa.tanks.models.weapon.terminator {
  import alternativa.math.Vector3;
  import alternativa.physics.Body;

  [ModelInterface]
  public interface Terminator {
    function primaryCharge(param1:int, param2:int) : void;
    function primaryShot(param1:int, param2:Vector3, param3:Vector.<Body>, param4:Vector.<Vector3>, param5:int) : void;
    function primaryDummyShot(param1:int, param2:int) : void;
    function secondaryOpen(param1:int) : void;
    function secondaryHide(param1:int) : void;
  }
}
