package projects.tanks.clients.flash.commons.models.runtime {
  import alternativa.types.Long;
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface DataOwner {
    function equals(param1:IGameObject) : Boolean;
    function getDataOwnerId() : Long;
  }
}
