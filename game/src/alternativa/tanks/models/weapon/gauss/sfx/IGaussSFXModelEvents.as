package alternativa.tanks.models.weapon.gauss.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IGaussSFXModelEvents implements IGaussSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IGaussSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSFXData() : GaussSFXData {
      var result:GaussSFXData = null;
      var i:int = 0;
      var m:IGaussSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IGaussSFXModel(this.impl[i]);
          result = m.getSFXData();
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
