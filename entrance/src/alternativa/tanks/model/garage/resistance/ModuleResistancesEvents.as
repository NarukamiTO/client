package alternativa.tanks.model.garage.resistance {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public class ModuleResistancesEvents implements ModuleResistances {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ModuleResistancesEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResistances() : Vector.<ItemGarageProperty> {
      var result:Vector.<ItemGarageProperty> = null;
      var i:int = 0;
      var m:ModuleResistances = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ModuleResistances(this.impl[i]);
          result = m.getResistances();
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
