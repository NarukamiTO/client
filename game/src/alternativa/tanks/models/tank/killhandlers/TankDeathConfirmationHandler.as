package alternativa.tanks.models.tank.killhandlers {
  import platform.client.fp10.core.type.IGameObject;

  public interface TankDeathConfirmationHandler {
    function handleDeathConfirmation(param1:IGameObject) : void;
  }
}
