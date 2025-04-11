package alternativa.tanks.model.garage {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class GarageEvents implements Garage {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function GarageEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function haveAbilityToMount(param1:IGameObject) : Boolean {
      var result:Boolean = false;
      var i:int = 0;
      var m:Garage = null;
      var item:IGameObject = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = Garage(this.impl[i]);
          result = Boolean(m.haveAbilityToMount(item));
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
