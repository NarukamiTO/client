package alternativa.tanks.model.garage {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface Garage {
    function haveAbilityToMount(param1:IGameObject) : Boolean;
  }
}
