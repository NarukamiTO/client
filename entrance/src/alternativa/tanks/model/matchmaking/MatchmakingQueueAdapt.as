package alternativa.tanks.model.matchmaking {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class MatchmakingQueueAdapt implements MatchmakingQueue {
    private var object:IGameObject;
    private var impl:MatchmakingQueue;

    public function MatchmakingQueueAdapt(param1:IGameObject, param2:MatchmakingQueue) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function registrationSuccessful() : void {
      try {
        Model.object = this.object;
        this.impl.registrationSuccessful();
      }
      finally {
        Model.popObject();
      }
    }

    public function registrationCancelled() : void {
      try {
        Model.object = this.object;
        this.impl.registrationCancelled();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
