package alternativa.tanks.models.weapon.laser {
  import alternativa.math.Matrix3;
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.tank.LocalTankInfoService;
  import alternativa.tanks.models.tank.TankPartReset;
  import alternativa.tanks.models.tank.ultimate.hunter.stun.UltimateStunListener;
  import alternativa.tanks.models.weapon.common.IWeaponCommonModel;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.impl.NotLoadedGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapon.laser.ILaserPointerModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapon.laser.LaserPointerModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;

  [ModelInfo]
  public class LaserPointerModel extends LaserPointerModelBase implements LaserPointer, ILaserPointerModelBase, TankPartReset, UltimateStunListener {
    [Inject]
    public static var battleService:BattleService;

    [Inject]
    public static var localTankInfoService:LocalTankInfoService;

    public function LaserPointerModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function updateRemoteDirection(param1:Number) : void {
      if(!isNaN(param1)) {
        this.doUpdateLaserDirection(param1);
      }
    }

    [Obfuscation(rename="false")]
    public function aimRemoteAtTank(param1:IGameObject, param2:Vector3d) : void {
      if(param1 == null || BattleUtils.isVector3dNaN(param2) || param1 is NotLoadedGameObject) {
        return;
      }
      var local3:ITankModel = ITankModel(param1.adapt(ITankModel));
      this.doAimAtTank(local3.getTank(),BattleUtils.getVector3(param2));
    }

    [Obfuscation(rename="false")]
    public function hideRemote() : void {
      this.doHideLaser();
    }

    public function updateDirection(param1:Vector3) : void {
      var local2:Matrix3 = BattleUtils.tmpMatrix3;
      local2.setRotationMatrixForObject3D(localTankInfoService.getLocalTank().getTurret3D());
      var local3:Vector3 = BattleUtils.tmpVector;
      local2.getUp(local3);
      var local4:Number = local3.dot(param1);
      if(this.doUpdateLaserDirection(local4)) {
        server.updateDirection(local4);
      }
    }

    public function aimAtTank(param1:Tank, param2:Vector3) : void {
      if(this.doAimAtTank(param1,param2)) {
        server.aimAtTank(param1.getUser(),BattleUtils.getVector3d(param2));
      }
    }

    public function hideLaser() : void {
      if(this.doHideLaser() && this.isLocalWeapon()) {
        server.hide();
      }
    }

    private function isLocalWeapon() : Boolean {
      var local1:Tank = IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
      return localTankInfoService.getLocalTankObject() == local1.user;
    }

    public function doUpdateLaserDirection(param1:Number) : Boolean {
      this.showLaserIfNeed();
      var local2:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
      return local2.updateDirection(param1);
    }

    private function doAimAtTank(param1:Tank, param2:Vector3) : Boolean {
      this.showLaserIfNeed();
      var local3:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
      return local3.aimAtTank(param1,param2);
    }

    private function showLaserIfNeed() : void {
      var local1:LaserPointerEffect = this.getOrCreateLaser();
      if(local1.isVisible()) {
        return;
      }
      var local2:Tank = this.getTank();
      var local3:Boolean = Boolean(ITankModel(local2.getUser().adapt(ITankModel)).isLocal());
      if(local3 && !getInitParam().locallyVisible) {
        local1.markAsVisible();
        return;
      }
      local1.show(this.getColorForTeam(local2.teamType));
    }

    private function getOrCreateLaser() : LaserPointerEffect {
      var local1:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
      if(local1 == null) {
        local1 = new LaserPointerEffect(getInitParam().fadeInTimeMs,this.getTank());
        putData(LaserPointerEffect,local1);
      }
      return local1;
    }

    public function resetTankPart(param1:Tank) : void {
      this.getOrCreateLaser().reset(param1);
    }

    private function getTank() : Tank {
      return IWeaponCommonModel(object.adapt(IWeaponCommonModel)).getTank();
    }

    private function doHideLaser() : Boolean {
      var local1:LaserPointerEffect = LaserPointerEffect(getData(LaserPointerEffect));
      if(Boolean(local1) && local1.isVisible()) {
        local1.hide();
        return true;
      }
      return false;
    }

    private function getColorForTeam(param1:BattleTeam) : uint {
      switch(param1) {
        case BattleTeam.BLUE:
          return this.getLaserPointerBlueColor();
        case BattleTeam.RED:
          return this.getLaserPointerRedColor();
        default:
          return this.getLaserPointerRedColor();
      }
    }

    public function getLaserPointerBlueColor() : uint {
      return uint(getInitParam().laserPointerBlueColor);
    }

    public function getLaserPointerRedColor() : uint {
      return uint(getInitParam().laserPointerRedColor);
    }

    public function onStun(param1:Tank, param2:Boolean) : void {
      this.doHideLaser();
    }

    public function onCalm(param1:Tank, param2:Boolean, param3:int) : void {
    }
  }
}
