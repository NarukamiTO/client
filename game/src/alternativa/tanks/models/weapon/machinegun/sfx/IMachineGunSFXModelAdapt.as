package alternativa.tanks.models.weapon.machinegun.sfx {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IMachineGunSFXModelAdapt implements IMachineGunSFXModel {
    private var object:IGameObject;
    private var impl:IMachineGunSFXModel;

    public function IMachineGunSFXModelAdapt(param1:IGameObject, param2:IMachineGunSFXModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getSfxData() : MachineGunSFXData {
      var result:MachineGunSFXData = null;
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
