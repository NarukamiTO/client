package alternativa.tanks.models.weapon.turret {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class TurretStateSenderEvents implements TurretStateSender {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function TurretStateSenderEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function sendTurretState() : void {
      var i:int = 0;
      var m:TurretStateSender = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = TurretStateSender(this.impl[i]);
          m.sendTurretState();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
