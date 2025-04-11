package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.tanks.models.sfx.lighting.LightingSfx;
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.IMachineGunSFXModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.machinegun.sfx.MachineGunSFXModelBase;

  [ModelInfo]
  public class MachineGunSFXModel extends MachineGunSFXModelBase implements IMachineGunSFXModelBase, IMachineGunSFXModel, ObjectLoadPostListener {
    public function MachineGunSFXModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:MachineGunSFXData = new MachineGunSFXData(getInitParam(),new LightingSfx(getInitParam().lightingSFXEntity));
      putData(MachineGunSFXData,local1);
    }

    public function getSfxData() : MachineGunSFXData {
      return MachineGunSFXData(getData(MachineGunSFXData));
    }
  }
}
