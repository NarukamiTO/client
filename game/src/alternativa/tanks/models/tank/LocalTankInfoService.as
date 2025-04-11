package alternativa.tanks.models.tank {
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.IGameObject;

  public interface LocalTankInfoService {
    function isLocalTankLoaded() : Boolean;
    function getLocalTankObject() : IGameObject;
    function getLocalTankObjectOrNull() : IGameObject;
    function getLocalTank() : Tank;
  }
}
