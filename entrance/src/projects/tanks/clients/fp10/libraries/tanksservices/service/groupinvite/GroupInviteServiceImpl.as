package projects.tanks.clients.fp10.libraries.tanksservices.service.groupinvite {
  import alternativa.types.Long;
  import flash.events.EventDispatcher;

  public class GroupInviteServiceImpl extends EventDispatcher implements GroupInviteService {
    public function GroupInviteServiceImpl() {
      super();
    }

    public function accept(param1:Long) : void {
      dispatchEvent(new GroupInviteServiceEvent(GroupInviteServiceEvent.ACCEPT,param1));
    }

    public function reject(param1:Long) : void {
      dispatchEvent(new GroupInviteServiceEvent(GroupInviteServiceEvent.REJECT,param1));
    }
  }
}
