package alternativa.tanks.models.weapons.targeting.direction.sector {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapon.AllGlobalGunParams;
  import alternativa.tanks.models.weapon.WeaponObject;
  import alternativa.tanks.models.weapon.angles.verticals.autoaiming.VerticalAutoAiming;
  import alternativa.tanks.services.tankregistry.TankUsersRegistry;
  import platform.client.fp10.core.type.IGameObject;

  public class TargetingSectorsCalculator {
    [Inject]
    public static var tankUsersRegistry:TankUsersRegistry;

    private var upDirection:Vector3 = new Vector3();
    private var self:IGameObject;
    private var maxDistance:Number;
    private var weapon:WeaponObject;

    public function TargetingSectorsCalculator(param1:IGameObject, param2:WeaponObject, param3:Number) {
      super();
      this.self = param1;
      this.weapon = param2;
      this.maxDistance = param3;
    }

    public function getSectors(param1:AllGlobalGunParams) : Vector.<TargetingSector> {
      var local3:IGameObject = null;
      var local2:Vector.<TargetingSector> = new Vector.<TargetingSector>();
      this.upDirection.cross2(param1.elevationAxis,param1.direction);
      for each(local3 in tankUsersRegistry.getUsers()) {
        if(local3 != this.self) {
          this.calculateSectorAndAdd(param1,this.upDirection,this.getTank(local3),local2);
        }
      }
      return local2;
    }

    private function calculateSectorAndAdd(param1:AllGlobalGunParams, param2:Vector3, param3:Tank, param4:Vector.<TargetingSector>) : void {
      var local5:Vector3 = BattleUtils.tmpVector;
      local5.diff(param3.getBody().state.position,param1.barrelOrigin);
      var local6:Number = local5.length();
      var local7:Number = Math.max(0,local5.length() - param3.getBoundSphereRadius());
      if(local7 > this.maxDistance) {
        return;
      }
      var local8:Vector3 = param1.elevationAxis;
      var local9:Vector3 = param1.direction;
      var local10:Number = local5.dot(local8);
      var local11:Number = local5.dot(local9);
      var local12:Number = local5.dot(param2);
      var local13:Number = Math.atan2(local10,local11);
      var local14:Number = Math.atan2(local12,local11);
      var local15:Number = Math.min(param3.getBoundSphereRadius(),local6);
      var local16:Number = Math.asin(local15 / local6);
      var local17:Number = local16;
      var local18:Number = local16;
      if(Math.abs(local13) > local17) {
        return;
      }
      var local19:VerticalAutoAiming = this.weapon.verticalAutoAiming();
      var local20:Number = Math.max(local14 - local18,-local19.getElevationAngleDown());
      var local21:Number = Math.min(local14 + local18,local19.getElevationAngleUp());
      if(local20 < local21) {
        param4.push(new TargetingSector(local20,local21,local7,param3));
      }
    }

    private function getTank(param1:IGameObject) : Tank {
      var local2:ITankModel = ITankModel(param1.adapt(ITankModel));
      return local2.getTank();
    }
  }
}
