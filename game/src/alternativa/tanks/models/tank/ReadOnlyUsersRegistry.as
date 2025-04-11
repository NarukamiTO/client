package alternativa.tanks.models.tank {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  public interface ReadOnlyUsersRegistry {
    function getUser(param1:Long) : IGameObject;
  }
}
