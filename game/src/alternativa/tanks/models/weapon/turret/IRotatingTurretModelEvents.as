package alternativa.tanks.models.weapon.turret {
  import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
  import alternativa.tanks.battle.objects.tank.controllers.Turret;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IRotatingTurretModelEvents implements IRotatingTurretModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function IRotatingTurretModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getLocalTurretController() : LocalTurretController {
      var result:LocalTurretController = null;
      var i:int = 0;
      var m:IRotatingTurretModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IRotatingTurretModel(this.impl[i]);
          result = m.getLocalTurretController();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTurret() : Turret {
      var result:Turret = null;
      var i:int = 0;
      var m:IRotatingTurretModel = null;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = IRotatingTurretModel(this.impl[i]);
          result = m.getTurret();
          i++;
        }
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
