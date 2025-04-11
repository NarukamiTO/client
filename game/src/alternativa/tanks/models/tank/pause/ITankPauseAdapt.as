package alternativa.tanks.models.tank.pause {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankPauseAdapt implements ITankPause {
    private var object:IGameObject;
    private var impl:ITankPause;

    public function ITankPauseAdapt(param1:IGameObject, param2:ITankPause) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function enablePause() : void {
      try {
        Model.object = this.object;
        this.impl.enablePause();
      }
      finally {
        Model.popObject();
      }
    }

    public function disablePause() : void {
      try {
        Model.object = this.object;
        this.impl.disablePause();
      }
      finally {
        Model.popObject();
      }
    }

    public function resetIdleKickTime() : void {
      try {
        Model.object = this.object;
        this.impl.resetIdleKickTime();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
