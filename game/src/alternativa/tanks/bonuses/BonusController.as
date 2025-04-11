package alternativa.tanks.bonuses {
  public interface BonusController {
    function start() : void;
    function runBeforePhysicsUpdate(param1:Number) : void;
    function interpolatePhysicsState(param1:Number) : void;
    function render() : void;
  }
}
