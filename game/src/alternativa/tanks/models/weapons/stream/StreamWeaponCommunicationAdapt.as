package alternativa.tanks.models.weapons.stream {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.objects.tank.Tank;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class StreamWeaponCommunicationAdapt implements StreamWeaponCommunication {
    private var object:IGameObject;
    private var impl:StreamWeaponCommunication;

    public function StreamWeaponCommunicationAdapt(param1:IGameObject, param2:StreamWeaponCommunication) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function fireStarted(param1:int) : void {
      var clientTime:int = param1;
      try {
        Model.object = this.object;
        this.impl.fireStarted(clientTime);
      }
      finally {
        Model.popObject();
      }
    }

    public function fireStopped(param1:int) : void {
      var clientTime:int = param1;
      try {
        Model.object = this.object;
        this.impl.fireStopped(clientTime);
      }
      finally {
        Model.popObject();
      }
    }

    public function targetUpdate(param1:int, param2:Vector3, param3:Tank) : void {
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      var target:Tank = param3;
      try {
        Model.object = this.object;
        this.impl.targetUpdate(clientTime,direction,target);
      }
      finally {
        Model.popObject();
      }
    }

    public function targetsUpdateDummy(param1:int, param2:Vector3) : void {
      var clientTime:int = param1;
      var direction:Vector3 = param2;
      try {
        Model.object = this.object;
        this.impl.targetsUpdateDummy(clientTime,direction);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
