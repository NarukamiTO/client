package alternativa.tanks.models.weapon.common {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IWeaponCommonModelAdapt implements IWeaponCommonModel {
    private var object:IGameObject;
    private var impl:IWeaponCommonModel;

    public function IWeaponCommonModelAdapt(param1:IGameObject, param2:IWeaponCommonModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCommonData() : WeaponCommonData {
      var result:WeaponCommonData = null;
      try {
        Model.object = this.object;
        result = this.impl.getCommonData();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function storeTank(param1:Tank) : void {
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        this.impl.storeTank(tank);
      }
      finally {
        Model.popObject();
      }
    }

    public function getTank() : Tank {
      var result:Tank = null;
      try {
        Model.object = this.object;
        result = this.impl.getTank();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGunParams(param1:int = 0) : AllGlobalGunParams {
      var result:AllGlobalGunParams = null;
      var barrelIndex:int = param1;
      try {
        Model.object = this.object;
        result = this.impl.getGunParams(barrelIndex);
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
