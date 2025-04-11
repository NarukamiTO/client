package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.resource.types.SoundResource;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponSoundEvents implements WeaponSound {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function WeaponSoundEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getTurretRotationSound() : SoundResource {
      var result:SoundResource = null;
      var i:int = 0;
      var m:WeaponSound = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = WeaponSound(this.impl[i]);
          result = m.getTurretRotationSound();
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
