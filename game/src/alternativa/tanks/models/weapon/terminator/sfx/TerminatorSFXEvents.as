package alternativa.tanks.models.weapon.terminator.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TerminatorSFXEvents implements TerminatorSFX {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TerminatorSFXEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : TerminatorSFXData {
      var result:TerminatorSFXData = null;
      var i:int = 0;
      var m:TerminatorSFX = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TerminatorSFX(this.impl[i]);
          result = m.getSfxData();
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
