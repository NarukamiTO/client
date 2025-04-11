package alternativa.tanks.models.tank.armor {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArmorAdapt implements Armor {
    private var object:IGameObject;
    private var impl:Armor;

    public function ArmorAdapt(param1:IGameObject, param2:Armor) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMaxHealth() : int {
      var result:int = 0;
      try {
        Model.object = this.object;
        result = int(this.impl.getMaxHealth());
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
