package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TargetShellWeaponListenerAdapt implements TargetShellWeaponListener {
    private var object:IGameObject;
    private var impl:TargetShellWeaponListener;

    public function TargetShellWeaponListenerAdapt(param1:IGameObject, param2:TargetShellWeaponListener) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function onShotWithTarget(param1:int, param2:int, param3:Vector3, param4:Tank, param5:Vector3) : void {
      var barrelIndex:int = param1;
      var shotId:int = param2;
      var direction:Vector3 = param3;
      var target:Tank = param4;
      var localTargetPoint:Vector3 = param5;
      try {
        Model.object = this.object;
        this.impl.onShotWithTarget(barrelIndex,shotId,direction,target,localTargetPoint);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
