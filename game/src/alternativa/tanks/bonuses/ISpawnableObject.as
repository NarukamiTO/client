package alternativa.tanks.bonuses {
  public interface ISpawnableObject {
    function setAlpha(param1:Number) : void;
    function addSignal(param1:Function) : void;
    function removeSignal(param1:Function) : void;
  }
}
