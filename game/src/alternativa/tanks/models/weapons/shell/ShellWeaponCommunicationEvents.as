package alternativa.tanks.models.weapons.shell {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.models.weapons.shell.states.ShellStates;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ShellWeaponCommunicationEvents implements ShellWeaponCommunication {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ShellWeaponCommunicationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function tryToShoot(param1:int, param2:int, param3:int, param4:Vector3) : void {
      var i:int = 0;
      var m:ShellWeaponCommunication = null;
      var clientTime:int = param1;
      var barrelIndex:int = param2;
      var shotId:int = param3;
      var direction:Vector3 = param4;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShellWeaponCommunication(this.impl[i]);
          m.tryToShoot(clientTime,barrelIndex,shotId,direction);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function tryToShootWithTarget(param1:int, param2:int, param3:int, param4:Vector3, param5:Tank, param6:Vector3) : void {
      var i:int = 0;
      var m:ShellWeaponCommunication = null;
      var clientTime:int = param1;
      var barrelIndex:int = param2;
      var shotId:int = param3;
      var direction:Vector3 = param4;
      var target:Tank = param5;
      var localTargetPoint:Vector3 = param6;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShellWeaponCommunication(this.impl[i]);
          m.tryToShootWithTarget(clientTime,barrelIndex,shotId,direction,target,localTargetPoint);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function tryToDummyShoot(param1:int, param2:int) : void {
      var i:int = 0;
      var m:ShellWeaponCommunication = null;
      var clientTime:int = param1;
      var barrelIndex:int = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShellWeaponCommunication(this.impl[i]);
          m.tryToDummyShoot(clientTime,barrelIndex);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function tryToHit(param1:int, param2:ShellStates, param3:Tank = null) : void {
      var i:int = 0;
      var m:ShellWeaponCommunication = null;
      var shotId:int = param1;
      var states:ShellStates = param2;
      var target:Tank = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ShellWeaponCommunication(this.impl[i]);
          m.tryToHit(shotId,states,target);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
