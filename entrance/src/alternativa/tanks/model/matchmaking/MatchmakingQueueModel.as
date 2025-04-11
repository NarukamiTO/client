package alternativa.tanks.model.matchmaking {
  import alternativa.tanks.service.battlelist.MatchmakingEvent;
  import alternativa.tanks.service.matchmaking.MatchmakingFormService;
  import platform.client.fp10.core.model.ObjectLoadListener;
  import platform.client.fp10.core.model.ObjectUnloadListener;
  import projects.tanks.client.battleselect.model.matchmaking.queue.IMatchmakingQueueModelBase;
  import projects.tanks.client.battleselect.model.matchmaking.queue.MatchmakingQueueModelBase;

  [ModelInfo]
  public class MatchmakingQueueModel extends MatchmakingQueueModelBase implements IMatchmakingQueueModelBase, ObjectLoadListener, ObjectUnloadListener, MatchmakingQueue {
    [Inject]
    public static var matchmakingFormService:MatchmakingFormService;

    private var isReceivedRegistrationResult:Boolean = true;

    public function MatchmakingQueueModel() {
      super();
    }

    public function objectLoaded() : void {
      this.isReceivedRegistrationResult = true;
      matchmakingFormService.addEventListener(MatchmakingEvent.REGISTRATION,getFunctionWrapper(this.onRegister));
      matchmakingFormService.addEventListener(MatchmakingEvent.UNREGISTRATION,getFunctionWrapper(this.onUnregister));
    }

    public function objectUnloaded() : void {
      matchmakingFormService.removeEventListener(MatchmakingEvent.REGISTRATION,getFunctionWrapper(this.onRegister));
      matchmakingFormService.removeEventListener(MatchmakingEvent.UNREGISTRATION,getFunctionWrapper(this.onUnregister));
    }

    private function onRegister(param1:MatchmakingEvent) : void {
      if(this.isReceivedRegistrationResult) {
        this.isReceivedRegistrationResult = false;
        server.register(param1.getMode());
      }
    }

    public function registrationSuccessful() : void {
      this.isReceivedRegistrationResult = true;
    }

    public function registrationCancelled() : void {
      this.isReceivedRegistrationResult = true;
    }

    private function onUnregister(param1:MatchmakingEvent) : void {
      server.unregister();
    }
  }
}
