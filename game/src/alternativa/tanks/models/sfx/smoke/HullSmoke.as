package alternativa.tanks.models.sfx.smoke {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface HullSmoke {
    function controlChanged(param1:IGameObject, param2:int) : void;
  }
}
