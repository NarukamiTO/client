package alternativa.tanks.models.user {
  import platform.client.fp10.core.type.IGameObject;

  [ModelInterface]
  public interface IClanUserModel {
    function loadingInServiceSpace() : Boolean;
    function addInClan(param1:IGameObject) : void;
    function rejectAll() : void;
    function revoke(param1:IGameObject) : void;
    function reject(param1:IGameObject) : void;
    function acceptRequest(param1:IGameObject) : void;
  }
}
