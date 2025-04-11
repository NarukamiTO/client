package alternativa.tanks.model.garage.resistance {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.commons.types.ItemGarageProperty;

  public class ModuleResistancesAdapt implements ModuleResistances {
    private var object:IGameObject;
    private var impl:ModuleResistances;

    public function ModuleResistancesAdapt(param1:IGameObject, param2:ModuleResistances) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getResistances() : Vector.<ItemGarageProperty> {
      var result:Vector.<ItemGarageProperty> = null;
      try {
        Model.object = this.object;
        result = this.impl.getResistances();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
