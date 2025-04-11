package alternativa.tanks.models.weapons.discrete {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.BattleUtils;
  import alternativa.tanks.battle.events.BattleEventDispatcher;
  import alternativa.tanks.battle.events.StateCorrectionEvent;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.DiscreteWeaponCommunicationModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.IDiscreteWeaponCommunicationModelBase;
  import projects.tanks.client.battlefield.models.tankparts.weapons.common.discrete.TargetHit;
  import projects.tanks.client.battlefield.types.Vector3d;

  [ModelInfo]
  public class DiscreteWeaponCommunicationModel extends DiscreteWeaponCommunicationModelBase implements IDiscreteWeaponCommunicationModelBase, DiscreteWeapon {
    [Inject]
    public static var battleEventDispatcher:BattleEventDispatcher;

    public function DiscreteWeaponCommunicationModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function shoot(param1:IGameObject, param2:Vector3d, param3:Vector.<TargetHit>) : void {
      var local4:DiscreteWeaponListener = DiscreteWeaponListener(object.event(DiscreteWeaponListener));
      local4.onShot(param1,BattleUtils.getVector3(param2),param3);
    }

    public function tryToShoot(param1:int, param2:Vector3, param3:Vector.<Tank>) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.tryToShoot(param1,BattleUtils.getVector3d(param2),BattleUtils.getTargetsPositions(param3));
    }

    public function tryToDummyShoot(param1:int, param2:Vector3) : void {
      battleEventDispatcher.dispatchEvent(StateCorrectionEvent.MANDATORY_UPDATE);
      server.tryToDummyShoot(param1,BattleUtils.getVector3d(param2));
    }
  }
}
