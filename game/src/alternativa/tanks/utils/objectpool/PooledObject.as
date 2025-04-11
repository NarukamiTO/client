package alternativa.tanks.utils.objectpool {
  public class PooledObject {
    private var pool:Pool;

    public function PooledObject(param1:Pool) {
      super();
      this.pool = param1;
    }

    final public function recycle() : void {
      this.pool.putObject(this);
    }
  }
}
