package alternativa.tanks.models.coloradjust {
  import flash.geom.ColorTransform;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IColorAdjustEvents implements IColorAdjust {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IColorAdjustEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getHWHeat() : ColorTransform {
      var result:ColorTransform = null;
      var i:int = 0;
      var m:IColorAdjust = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColorAdjust(this.impl[i]);
          result = m.getHWHeat();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getHWFrost() : ColorTransform {
      var result:ColorTransform = null;
      var i:int = 0;
      var m:IColorAdjust = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColorAdjust(this.impl[i]);
          result = m.getHWFrost();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoftHeat() : ColorTransform {
      var result:ColorTransform = null;
      var i:int = 0;
      var m:IColorAdjust = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColorAdjust(this.impl[i]);
          result = m.getSoftHeat();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getSoftFrost() : ColorTransform {
      var result:ColorTransform = null;
      var i:int = 0;
      var m:IColorAdjust = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IColorAdjust(this.impl[i]);
          result = m.getSoftFrost();
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
