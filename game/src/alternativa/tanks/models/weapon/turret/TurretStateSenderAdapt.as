package alternativa.tanks.models.weapon.turret {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TurretStateSenderAdapt implements TurretStateSender {
    private var object:IGameObject;
    private var impl:TurretStateSender;

    public function TurretStateSenderAdapt(param1:IGameObject, param2:TurretStateSender) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function sendTurretState() : void {
      try {
        Model.object = this.object;
        this.impl.sendTurretState();
      }
      finally {
        Model.popObject();
      }
    }
  }
}
