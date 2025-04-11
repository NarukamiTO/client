package alternativa.tanks.models.battle.rugby.explosion {
  import alternativa.math.Vector3;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class BallExplosionEvents implements BallExplosion {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function BallExplosionEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function createExplosionEffects(param1:Vector3) : void {
      var i:int = 0;
      var m:BallExplosion = null;
      var position:Vector3 = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = BallExplosion(this.impl[i]);
          m.createExplosionEffects(position);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
