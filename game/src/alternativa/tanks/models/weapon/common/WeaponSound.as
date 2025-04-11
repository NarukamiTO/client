package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.resource.types.SoundResource;

  [ModelInterface]
  public interface WeaponSound {
    function getTurretRotationSound() : SoundResource;
  }
}
