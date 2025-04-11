package alternativa.tanks.models.tank.ultimate {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IUltimateModelEvents implements IUltimateModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IUltimateModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function resetCharge() : void {
      var i:int = 0;
      var m:IUltimateModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUltimateModel(this.impl[i]);
          m.resetCharge();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function initIndicator() : void {
      var i:int = 0;
      var m:IUltimateModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUltimateModel(this.impl[i]);
          m.initIndicator();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function isUltimateEnabled() : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:IUltimateModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUltimateModel(this.impl[i]);
          result = Boolean(m.isUltimateEnabled());
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function effectDeactivated() : void {
      var i:int = 0;
      var m:IUltimateModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUltimateModel(this.impl[i]);
          m.effectDeactivated();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function effectActivatedOrMerged(param1:int) : void {
      var i:int = 0;
      var m:IUltimateModel = null;
      var leftTimeInMs:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IUltimateModel(this.impl[i]);
          m.effectActivatedOrMerged(leftTimeInMs);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
