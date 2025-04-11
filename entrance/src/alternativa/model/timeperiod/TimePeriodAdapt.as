package alternativa.model.timeperiod {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TimePeriodAdapt implements TimePeriod {
    private var object:IGameObject;
    private var impl:TimePeriod;

    public function TimePeriodAdapt(param1:IGameObject, param2:TimePeriod) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isTimeless() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isTimeless());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getModelLoadingTimeInMillis() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getModelLoadingTimeInMillis());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTimeLeftInSeconds() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getTimeLeftInSeconds());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTimeToStartInSeconds() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getTimeToStartInSeconds());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
