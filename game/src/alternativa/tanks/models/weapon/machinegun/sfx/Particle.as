package alternativa.tanks.models.weapon.machinegun.sfx {
  import alternativa.tanks.utils.objectpool.Pool;
  import alternativa.tanks.utils.objectpool.PooledObject;

  public class Particle extends PooledObject {
    private var _alive:Boolean;

    public function Particle(param1:Pool) {
      super(param1);
    }

    public function get alive() : Boolean {
      return this._alive;
    }

    public function set alive(param1:Boolean) : void {
      this._alive = param1;
    }
  }
}
