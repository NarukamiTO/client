package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponSoundAdapt implements WeaponSound {
    private var object:IGameObject;
    private var impl:WeaponSound;

    public function WeaponSoundAdapt(param1:IGameObject, param2:WeaponSound) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getTurretRotationSound() : SoundResource {
      var result:SoundResource = null;
      try {
        Model.object = this.object;
        result = this.impl.getTurretRotationSound();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
