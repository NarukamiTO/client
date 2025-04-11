package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FacilityDispellEffectEvents implements FacilityDispellEffect {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function FacilityDispellEffectEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createDispellEffects(param1:Vector3) : void {
      var i:int = 0;
      var m:FacilityDispellEffect = null;
      var position:Vector3 = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = FacilityDispellEffect(this.impl[i]);
          m.createDispellEffects(position);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
