package alternativa.tanks.models.effects.durationTime {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IDurationAdapt implements IDuration {
    private var object:IGameObject;
    private var impl:IDuration;

    public function IDurationAdapt(param1:IGameObject, param2:IDuration) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDurationTimeInMs() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getDurationTimeInMs());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isInfinite() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isInfinite());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
