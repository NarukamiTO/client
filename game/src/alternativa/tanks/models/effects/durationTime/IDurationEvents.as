package alternativa.tanks.models.effects.durationTime {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IDurationEvents implements IDuration {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IDurationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getDurationTimeInMs() : int {
      var result:int = 0;
      var i:int = 0;
      var m:IDuration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDuration(this.impl[i]);
          result = int(m.getDurationTimeInMs());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isInfinite() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IDuration = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IDuration(this.impl[i]);
          result = Boolean(m.isInfinite());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
