package alternativa.tanks.models.tank.explosion {
  import alternativa.tanks.battle.objects.tank.Tank;
  import alternativa.tanks.sfx.LightAnimation;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ITankExplosionModelEvents implements ITankExplosionModel {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ITankExplosionModelEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createExplosionEffects(param1:IGameObject, param2:Tank, param3:LightAnimation) : void {
      var i:int = 0;
      var m:ITankExplosionModel = null;
      var clientObject:IGameObject = param1;
      var tank:Tank = param2;
      var lighting:LightAnimation = param3;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ITankExplosionModel(this.impl[i]);
          m.createExplosionEffects(clientObject,tank,lighting);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
