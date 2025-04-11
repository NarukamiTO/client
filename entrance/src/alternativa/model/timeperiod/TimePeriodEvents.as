package alternativa.model.timeperiod {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TimePeriodEvents implements TimePeriod {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TimePeriodEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function isEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:TimePeriod = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TimePeriod(this.impl[i]);
          result = Boolean(m.isEnabled());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isTimeless() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:TimePeriod = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TimePeriod(this.impl[i]);
          result = Boolean(m.isTimeless());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getModelLoadingTimeInMillis() : int {
      var result:int = 0;
      var i:int = 0;
      var m:TimePeriod = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TimePeriod(this.impl[i]);
          result = int(m.getModelLoadingTimeInMillis());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTimeLeftInSeconds() : int {
      var result:int = 0;
      var i:int = 0;
      var m:TimePeriod = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TimePeriod(this.impl[i]);
          result = int(m.getTimeLeftInSeconds());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTimeToStartInSeconds() : int {
      var result:int = 0;
      var i:int = 0;
      var m:TimePeriod = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TimePeriod(this.impl[i]);
          result = int(m.getTimeToStartInSeconds());
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
