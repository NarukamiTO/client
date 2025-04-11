package projects.tanks.clients.fp10.libraries.tanksservices.service.clan {
  import alternativa.types.Long;

  public interface ClanFunctionsService {
    function invite(param1:Long) : void;
    function leave() : void;
    function exclude(param1:Long) : void;
    function revokeRequest(param1:Long) : void;
    function acceptRequest(param1:Long) : void;
    function rejectRequest(param1:Long) : void;
    function rejectAllRequests() : void;
  }
}
