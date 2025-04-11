package alternativa.tanks.models.weapon.gauss.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IGaussSFXModelAdapt implements IGaussSFXModel {
    private var object:IGameObject;
    private var impl:IGaussSFXModel;

    public function IGaussSFXModelAdapt(param1:IGameObject, param2:IGaussSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSFXData() : GaussSFXData {
      var result:GaussSFXData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSFXData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
