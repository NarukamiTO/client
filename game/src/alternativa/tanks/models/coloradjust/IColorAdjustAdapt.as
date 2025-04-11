package alternativa.tanks.models.coloradjust {
  import flash.geom.ColorTransform;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IColorAdjustAdapt implements IColorAdjust {
    private var object:IGameObject;
    private var impl:IColorAdjust;

    public function IColorAdjustAdapt(param1:IGameObject, param2:IColorAdjust) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getHWHeat() : ColorTransform {
      var result:ColorTransform = null;
      try {
        Model.object = this.object;
        result = this.impl.getHWHeat();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getHWFrost() : ColorTransform {
      var result:ColorTransform = null;
      try {
        Model.object = this.object;
        result = this.impl.getHWFrost();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoftHeat() : ColorTransform {
      var result:ColorTransform = null;
      try {
        Model.object = this.object;
        result = this.impl.getSoftHeat();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoftFrost() : ColorTransform {
      var result:ColorTransform = null;
      try {
        Model.object = this.object;
        result = this.impl.getSoftFrost();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
