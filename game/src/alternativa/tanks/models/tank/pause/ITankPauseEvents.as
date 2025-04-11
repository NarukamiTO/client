package alternativa.tanks.models.tank.pause {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankPauseEvents implements ITankPause {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITankPauseEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function enablePause() : void {
      var i:int = 0;
      var m:ITankPause = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankPause(this.impl[i]);
          m.enablePause();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function disablePause() : void {
      var i:int = 0;
      var m:ITankPause = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankPause(this.impl[i]);
          m.disablePause();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function resetIdleKickTime() : void {
      var i:int = 0;
      var m:ITankPause = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankPause(this.impl[i]);
          m.resetIdleKickTime();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
