package alternativa.tanks.models.weapon.turret {
  import alternativa.tanks.battle.objects.tank.controllers.LocalTurretController;
  import alternativa.tanks.battle.objects.tank.controllers.Turret;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class IRotatingTurretModelAdapt implements IRotatingTurretModel {
    private var object:IGameObject;
    private var impl:IRotatingTurretModel;

    public function IRotatingTurretModelAdapt(param1:IGameObject, param2:IRotatingTurretModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function getLocalTurretController() : LocalTurretController {
      var result:LocalTurretController = null;
      try {
        Model.object = this.object;
        result = this.impl.getLocalTurretController();
      }
      finally {
        Model.popObject();
      }
      return result;
    }

    public function getTurret() : Turret {
      var result:Turret = null;
      try {
        Model.object = this.object;
        result = this.impl.getTurret();
      }
      finally {
        Model.popObject();
      }
      return result;
    }
  }
}
