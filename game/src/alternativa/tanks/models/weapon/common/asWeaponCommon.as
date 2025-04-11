package alternativa.tanks.models.weapon.common {
  import platform.client.fp10.core.type.IGameObject;

  public function asWeaponCommon(param1:IGameObject) : IWeaponCommonModel {
    return IWeaponCommonModel(param1.adapt(IWeaponCommonModel));
  }
}
