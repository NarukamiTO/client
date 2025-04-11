package alternativa.tanks.models.weapon {
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import alternativa.tanks.models.weapon.common.WeaponCommonData;
  import alternativa.tanks.models.weapon.shared.shot.IShotModel;
  import alternativa.tanks.models.weapon.weakening.DistanceWeakening;
  import alternativa.tanks.models.weapon.weakening.IWeaponWeakeningModel;
  import flash.events.EventDispatcher;
  import platform.client.fp10.core.type.IGameObject;

  public class WeaponObject extends EventDispatcher {
    protected var remote:Boolean = false;
    protected var object:IGameObject;

    public function WeaponObject(param1:IGameObject) {
      super();
      this.object = param1;
    }

    public function verticalAutoAiming() : VerticalAutoAiming {
      return VerticalAutoAiming(this.object.adapt(VerticalAutoAiming));
    }

    public function getReloadTimeMS() : int {
      var local1:IShotModel = IShotModel(this.object.adapt(IShotModel));
      return local1.getReloadMS();
    }

    public function commonData() : WeaponCommonData {
      return this.weaponCommon().getCommonData();
    }

    public function weaponCommon() : IWeaponCommonModel {
      return IWeaponCommonModel(this.object.adapt(IWeaponCommonModel));
    }

    public function distanceWeakening() : DistanceWeakening {
      var local1:IWeaponWeakeningModel = IWeaponWeakeningModel(this.object.adapt(IWeaponWeakeningModel));
      return local1.getDistanceWeakening();
    }

    public function setObject(param1:IGameObject) : void {
      this.object = param1;
    }

    public function getObject() : IGameObject {
      return this.object;
    }

    public function isAlive() : Boolean {
      return this.object.space != null;
    }

    public function isLocal() : Boolean {
      return !this.remote;
    }

    public function markAsRemote() : void {
      this.remote = true;
    }
  }
}
