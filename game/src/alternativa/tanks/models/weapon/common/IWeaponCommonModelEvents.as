package alternativa.tanks.models.weapon.common {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IWeaponCommonModelEvents implements IWeaponCommonModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IWeaponCommonModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getCommonData() : WeaponCommonData {
      var result:WeaponCommonData = null;
      var i:int = 0;
      var m:IWeaponCommonModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponCommonModel(this.impl[i]);
          result = m.getCommonData();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function storeTank(param1:Tank) : void {
      var i:int = 0;
      var m:IWeaponCommonModel = null;
      var tank:Tank = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponCommonModel(this.impl[i]);
          m.storeTank(tank);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function getTank() : Tank {
      var result:Tank = null;
      var i:int = 0;
      var m:IWeaponCommonModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponCommonModel(this.impl[i]);
          result = m.getTank();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getGunParams(param1:int = 0) : AllGlobalGunParams {
      var result:AllGlobalGunParams = null;
      var i:int = 0;
      var m:IWeaponCommonModel = null;
      var barrelIndex:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IWeaponCommonModel(this.impl[i]);
          result = m.getGunParams(barrelIndex);
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
