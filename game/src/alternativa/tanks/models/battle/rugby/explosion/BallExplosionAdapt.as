package alternativa.tanks.models.battle.rugby.explosion {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BallExplosionAdapt implements BallExplosion {
    private var object:IGameObject;
    private var impl:BallExplosion;

    public function BallExplosionAdapt(param1:IGameObject, param2:BallExplosion) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createExplosionEffects(param1:Vector3) : void {
      var position:Vector3 = param1;
      try {
        Model.object = this.object;
        this.impl.createExplosionEffects(position);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
