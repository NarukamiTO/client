package alternativa.tanks.models.tank.explosion {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.sfx.LightAnimation;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankExplosionModelAdapt implements ITankExplosionModel {
    private var object:IGameObject;
    private var impl:ITankExplosionModel;

    public function ITankExplosionModelAdapt(param1:IGameObject, param2:ITankExplosionModel) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createExplosionEffects(param1:IGameObject, param2:Tank, param3:LightAnimation) : void {
      var clientObject:IGameObject = param1;
      var tank:Tank = param2;
      var lighting:LightAnimation = param3;
      try {
        Model.object = this.object;
        this.impl.createExplosionEffects(clientObject,tank,lighting);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
