package projects.tanks.clients.fp10.libraries.tanksservices.service.group {
  import alternativa.types.Long;

  public interface IGroupInfoService {
    function addGroupUser(param1:Long) : *;
    function isInSameGroup(param1:Long) : Boolean;
    function hasGroups() : Boolean;
    function setHasGroups(param1:Boolean) : *;
  }
}
