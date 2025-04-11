package alternativa.tanks.models.tank.ultimate {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IUltimateModelAdapt implements IUltimateModel {
    private var object:IGameObject;
    private var impl:IUltimateModel;

    public function IUltimateModelAdapt(param1:IGameObject, param2:IUltimateModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function resetCharge() : void {
      try {
        Model.object = this.object;
        this.impl.resetCharge();
      }
      finally {
        Model.popObject();
      }
    }

    public function initIndicator() : void {
      try {
        Model.object = this.object;
        this.impl.initIndicator();
      }
      finally {
        Model.popObject();
      }
    }

    public function isUltimateEnabled() : Boolean {
      var result:Boolean = false;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.isUltimateEnabled());
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function effectDeactivated() : void {
      try {
        Model.object = this.object;
        this.impl.effectDeactivated();
      }
      finally {
        Model.popObject();
      }
    }

    public function effectActivatedOrMerged(param1:int) : void {
      var leftTimeInMs:int = param1;
      try {
        Model.object = this.object;
        this.impl.effectActivatedOrMerged(leftTimeInMs);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
