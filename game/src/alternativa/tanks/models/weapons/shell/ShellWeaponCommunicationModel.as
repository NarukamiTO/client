package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleService;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.tank.ITankModel;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.TargetPosition;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.IShellWeaponCommunicationModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellHit;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellState;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.shell.ShellWeaponCommunicationModelBase;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class ShellWeaponCommunicationModel extends ShellWeaponCommunicationModelBase implements IShellWeaponCommunicationModelBase, ShellWeaponCommunication {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    [Inject]
    public static var battleService:BattleService;

    public function ShellWeaponCommunicationModel() {
      super();
    }

    public function tryToShoot(param1:int, param2:int, param3:int, param4:Vector3) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.tryToShoot(param1,param2,param3,BattleUtils.getVector3d(param4));
    }

    public function tryToShootWithTarget(param1:int, param2:int, param3:int, param4:Vector3, param5:Tank, param6:Vector3) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.tryToShootWithTarget(param1,param2,param3,BattleUtils.getVector3d(param4),BattleUtils.getTargetPosition(param5),BattleUtils.getVector3d(param6));
    }

    public function tryToDummyShoot(param1:int, param2:int) : void {
      server.tryToDummyShoot(param1,param2);
    }

    public function tryToHit(param1:int, param2:ShellStates, param3:Tank = null) : void {
      var local4:ShellHit = new ShellHit(param1,new Vector.<ShellState>(),new Vector.<TargetPosition>());
      if(param3 != null) {
        local4.targets.push(BattleUtils.getTargetPosition(param3));
      }
      local4.states = param2.getControlStates();
      server.tryToHit(battleService.getPhysicsTime(),local4);
    }

    public function shoot(param1:int, param2:int, param3:Vector3d) : void {
      var local4:ShellWeaponListener = ShellWeaponListener(object.event(ShellWeaponListener));
      local4.onShot(param1,param2,BattleUtils.getVector3(param3));
    }

    public function shootDummy(param1:int) : void {
      var local2:ShellWeaponListener = ShellWeaponListener(object.event(ShellWeaponListener));
      local2.onDummyShot(param1);
    }

    public function shootWithTarget(param1:int, param2:int, param3:Vector3d, param4:TargetPosition, param5:Vector3d) : void {
      var local6:ITankModel = ITankModel(param4.target.adapt(ITankModel));
      var local7:TargetShellWeaponListener = TargetShellWeaponListener(object.event(TargetShellWeaponListener));
      local7.onShotWithTarget(param1,param2,BattleUtils.getVector3(param3),local6.getTank(),BattleUtils.getVector3(param5));
    }
  }
}
