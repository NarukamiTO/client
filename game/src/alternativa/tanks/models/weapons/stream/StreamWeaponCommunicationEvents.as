package alternativa.tanks.models.weapons.stream {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class StreamWeaponCommunicationEvents implements StreamWeaponCommunication {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function StreamWeaponCommunicationEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function fireStarted(param1:int) : void {
      var i:int = 0;
      var m:StreamWeaponCommunication = null;
      var clientTime:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponCommunication(this.impl[i]);
          m.fireStarted(clientTime);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function fireStopped(param1:int) : void {
      var i:int = 0;
      var m:StreamWeaponCommunication = null;
      var clientTime:int = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponCommunication(this.impl[i]);
          m.fireStopped(clientTime);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function targetUpdate(param1:int, param2:Vector3, param3:Tank) : void {
      var i:int = 0;
      var m:StreamWeaponCommunication = null;
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      var target:Tank = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponCommunication(this.impl[i]);
          m.targetUpdate(clientTime,direction,target);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }

    public function targetsUpdateDummy(param1:int, param2:Vector3) : void {
      var i:int = 0;
      var m:StreamWeaponCommunication = null;
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = StreamWeaponCommunication(this.impl[i]);
          m.targetsUpdateDummy(clientTime,direction);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
