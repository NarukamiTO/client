package alternativa.tanks.models.weapon.gauss {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GaussSkinAdapt implements GaussSkin {
    private var object:IGameObject;
    private var impl:GaussSkin;

    public function GaussSkinAdapt(param1:IGameObject, param2:GaussSkin) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkin() : GaussTurretSkin {
      var result:GaussTurretSkin = null;
      try {
        Model.object = this.object;
        result = this.impl.getSkin();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
