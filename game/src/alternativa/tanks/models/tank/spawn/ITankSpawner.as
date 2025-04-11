package alternativa.tanks.models.tank.spawn {
  [ModelInterface]
  public interface ITankSpawner {
    function getIncarnationId() : int;
    function readyToSpawn() : void;
    function setLocal() : void;
    function setRemote() : void;
    function setReadyToPlace() : void;
  }
}
