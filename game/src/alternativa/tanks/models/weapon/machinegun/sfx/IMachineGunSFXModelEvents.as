package alternativa.tanks.models.weapon.machinegun.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IMachineGunSFXModelEvents implements IMachineGunSFXModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IMachineGunSFXModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : MachineGunSFXData {
      var result:MachineGunSFXData = null;
      var i:int = 0;
      var m:IMachineGunSFXModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IMachineGunSFXModel(this.impl[i]);
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
