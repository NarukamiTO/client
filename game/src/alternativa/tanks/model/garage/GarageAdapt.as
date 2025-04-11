package alternativa.tanks.model.garage {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GarageAdapt implements Garage {
    private var object:IGameObject;
    private var impl:Garage;

    public function GarageAdapt(param1:IGameObject, param2:Garage) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function haveAbilityToMount(param1:IGameObject) : Boolean {
      var result:Boolean = false;
      var item:IGameObject = param1;
      try {
        Model.object = this.object;
        result = Boolean(this.impl.haveAbilityToMount(item));
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
