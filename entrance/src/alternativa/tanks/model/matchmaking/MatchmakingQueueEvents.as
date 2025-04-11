package alternativa.tanks.model.matchmaking {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class MatchmakingQueueEvents implements MatchmakingQueue {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function MatchmakingQueueEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function registrationSuccessful() : void {
      var i:int = 0;
      var m:MatchmakingQueue = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MatchmakingQueue(this.impl[i]);
          m.registrationSuccessful();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function registrationCancelled() : void {
      var i:int = 0;
      var m:MatchmakingQueue = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = MatchmakingQueue(this.impl[i]);
          m.registrationCancelled();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
