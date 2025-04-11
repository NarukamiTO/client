package alternativa.tanks.model.item.temporary {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITemporaryItemEvents implements ITemporaryItem {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITemporaryItemEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getStopDate() : Date {
      var result:Date = null;
      var i:int = 0;
      var m:ITemporaryItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          result = m.getStopDate();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function startTiming(param1:int) : void {
      var i:int = 0;
      var m:ITemporaryItem = null;
      var remainingTime:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          m.startTiming(remainingTime);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function setRemainingTime(param1:int) : void {
      var i:int = 0;
      var m:ITemporaryItem = null;
      var remainingTime:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          m.setRemainingTime(remainingTime);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getTimeRemainingInMSec() : Number {
      var result:Number = NaN;
      var i:int = 0;
      var m:ITemporaryItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          result = Number(m.getTimeRemainingInMSec());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getLifeTimeInSec() : int {
      var result:int = 0;
      var i:int = 0;
      var m:ITemporaryItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          result = int(m.getLifeTimeInSec());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function isInfinityLifeTimeItem() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:ITemporaryItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          result = Boolean(m.isInfinityLifeTimeItem());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function markAsInfinityLifeTimeItem() : void {
      var i:int = 0;
      var m:ITemporaryItem = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITemporaryItem(this.impl[i]);
          m.markAsInfinityLifeTimeItem();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
