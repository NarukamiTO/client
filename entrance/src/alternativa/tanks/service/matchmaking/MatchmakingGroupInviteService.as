package alternativa.tanks.service.matchmaking {
  import flash.events.IEventDispatcher;

  public interface MatchmakingGroupInviteService extends IEventDispatcher {
    function openInviteWindow() : void;
  }
}
