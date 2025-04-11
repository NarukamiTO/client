package projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite {
  import alternativa.types.Long;
  import flash.events.IEventDispatcher;

  public interface GroupInviteService extends IEventDispatcher {
    function accept(param1:Long) : void;
    function reject(param1:Long) : void;
  }
}
