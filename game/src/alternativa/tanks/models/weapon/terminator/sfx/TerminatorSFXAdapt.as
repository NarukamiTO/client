package alternativa.tanks.models.weapon.terminator.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TerminatorSFXAdapt implements TerminatorSFX {
    private var object:IGameObject;
    private var impl:TerminatorSFX;

    public function TerminatorSFXAdapt(param1:IGameObject, param2:TerminatorSFX) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : TerminatorSFXData {
      var result:TerminatorSFXData = null;
      try {
        Model.object = this.object;
        result = this.impl.getSfxData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
