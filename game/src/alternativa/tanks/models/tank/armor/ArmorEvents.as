package alternativa.tanks.models.tank.armor {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ArmorEvents implements Armor {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ArmorEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getMaxHealth() : int {
      var result:int = 0;
      var i:int = 0;
      var m:Armor = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Armor(this.impl[i]);
          result = int(m.getMaxHealth());
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
