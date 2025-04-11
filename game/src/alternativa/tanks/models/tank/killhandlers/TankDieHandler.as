package alternativa.tanks.models.tank.killhandlers {
  import platform.client.fp10.core.type.IGameObject;

  public interface TankDieHandler {
    function handleTankDie(param1:IGameObject, param2:int) : void;
  }
}
