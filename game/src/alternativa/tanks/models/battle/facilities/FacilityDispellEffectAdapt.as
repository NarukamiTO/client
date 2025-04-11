package alternativa.tanks.models.battle.facilities {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class FacilityDispellEffectAdapt implements FacilityDispellEffect {
    private var object:IGameObject;
    private var impl:FacilityDispellEffect;

    public function FacilityDispellEffectAdapt(param1:IGameObject, param2:FacilityDispellEffect) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createDispellEffects(param1:Vector3) : void {
      var position:Vector3 = param1;
      try {
        Model.object = this.object;
        this.impl.createDispellEffects(position);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
