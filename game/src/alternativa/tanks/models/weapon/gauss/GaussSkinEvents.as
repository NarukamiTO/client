package alternativa.tanks.models.weapon.gauss {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GaussSkinEvents implements GaussSkin {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GaussSkinEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSkin() : GaussTurretSkin {
      var result:GaussTurretSkin = null;
      var i:int = 0;
      var m:GaussSkin = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = GaussSkin(this.impl[i]);
          result = m.getSkin();
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
